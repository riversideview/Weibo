//
//  HomeViewController.swift
//  Weibo
//
//  Created by Riversideview on 15/12/24.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit
import YYModel
import SDWebImage
import MJRefresh

class HomeViewController: UITableViewController {
    
    /// ViewModel包含了微博信息
    var subviewFrames = [StatusCellSubviewFrame]()

    /// 顶部IDbutton
    let idButton = IDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupRefreshControl()
        setupIDButton()

    }
    var newStatusView: UIButton!
    
    ///显示新微博数量
    func showNewStatusesCount(count: Int) {
        resetnewStatusView()
        self.navigationController?.view.insertSubview(newStatusView, belowSubview: self.navigationController!.navigationBar)
        
        count > 0 ? newStatusView.setTitle("\(count)条新微博", forState: .Normal) : newStatusView.setTitle("暂无新微博", forState: .Normal)

        UIView.animateWithDuration(0.7, animations: {
                self.newStatusView.transform = CGAffineTransformMakeTranslation(0, 30)
            }, completion: { finished in
                UIView.animateWithDuration(0.7, delay: 1.5, options: .OverrideInheritedCurve, animations: { () -> Void in
                    self.newStatusView.alpha = 0
                    }, completion: {(_) -> Void in
                    self.newStatusView.removeFromSuperview()
                })
        })
        
        
    }
    func idButtonClick() {
        idButton.click()
        print(self.navigationItem.rightBarButtonItem?.titleTextAttributesForState(.Disabled))
        print(self.navigationItem.rightBarButtonItem?.titleTextAttributesForState(.Normal))
        print(self.navigationItem.leftBarButtonItem?.titleTextAttributesForState(.Disabled))
        print(self.navigationItem.leftBarButtonItem?.titleTextAttributesForState(.Normal))

    }


    func setupRefreshControl() {
        let header = MJRefreshNormalHeader {
            self.setupStatus()
        }
        header.lastUpdatedTimeLabel?.hidden = true
        header.setTitle("下拉更新", forState: .Idle)
        header.setTitle("释放更新", forState: .Pulling)
        header.setTitle("加载中...", forState: .Refreshing)
        self.tableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter {
            self.getPastStatus()
        }
        footer.setTitle("加载更多微博", forState: .Idle)
        footer.setTitle("加载中...", forState: .Refreshing)
        self.tableView.mj_footer = footer
        self.tableView.mj_header.beginRefreshing()

    }
    deinit {
        self.removeObserver(self, forKeyPath: "title")
        print("released")
    }
    
    
    func friendattention() {
        print("friend")
        
    }
    func radar() {
        print("radar")
    }
    /**
     上拉获取之前微博
     */
    func getPastStatus() {
        let params = StatusRequestParams()
        if subviewFrames.count > 0 {//有微博的时候的刷新
            if let max_id = self.subviewFrames.last?.status.idstr {
                if let token = AccountTool.localAccount?.access_token {
                    params.access_token = token
                    params.max_id = String(Int64(max_id)! - 1)
                    params.count = "5"
                }
            }
            
        } else if let token = AccountTool.localAccount?.access_token {
            //无微博时的刷新
            params.access_token = token
            params.count = "5"
        }
        StatusTool.ShowHomeStatusWith(params, success: {
            (timeline: TimeLine) -> Void in
            var pastStatuses = [StatusCellSubviewFrame]()
            if let statuses = timeline.statuses as? [Status] {
                for status in statuses {
                    let controller = StatusCellSubviewFrame()
                    controller.status = status
                    pastStatuses.append(controller)
                }
            }
            self.subviewFrames.appendContentsOf(pastStatuses)
            self.tableView.mj_footer.endRefreshing()
            print("完成刷新")
            self.tableView.reloadData()
            }) { (error: NSError) -> Void in
                print(error)
                self.tableView.mj_header.endRefreshing()
        }
    }
    
    /**
     下拉获得最新微博
     */
    func setupStatus() {

        let params = StatusRequestParams()
        if subviewFrames.count > 0 { //已经有微博获取更多微博
            if let since_id = self.subviewFrames.first?.status.idstr {
                if let token = AccountTool.localAccount?.access_token {
                    params.access_token = token
                    params.since_id = since_id
                }
            }
        } else if let token = AccountTool.localAccount?.access_token {
            //初次进入获取微博
            params.access_token = token
            params.count = "5"
        }
        
        StatusTool.ShowHomeStatusWith(params, success: {
            (timeline: TimeLine) -> Void in
            var newStatuses = [StatusCellSubviewFrame]()
            if let statuses = timeline.statuses as? [Status] {
                for status in statuses {
                    let controller = StatusCellSubviewFrame()
                    controller.status = status
                    newStatuses.append(controller)
                }
            }
            self.subviewFrames.insertContentsOf(newStatuses, at: 0)
            self.showNewStatusesCount(newStatuses.count)
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
            }) { (error: NSError) -> Void in
                print(error)
                self.tableView.mj_header.endRefreshing()
        }
        
    }
    /**
     配置NavBar
     */
    func setupNavBar() {
        
        //创建ID按钮
        self.idButton.addTarget(self, action: "idButtonClick", forControlEvents: .TouchUpInside)
        self.navigationController?.navigationBar.addSubview(idButton)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.addIconWithItem(image: "navigationbar_friendattention", highlight: "navigationbar_friendattention_highlighted", target: self, selector: "friendattention")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.addIconWithItem(image: "navigationbar_icon_radar", highlight: "navigationbar_icon_radar_highlighted", target: self, selector: "radar")
        self.navigationController?.navigationBar.barStyle = .Default
        
        //去除分割
        self.tableView.separatorStyle = .None
    }
    
    ///初始化顶部IDButton内容
    func setupIDButton() {
        let params = LoginUserRequestParams()
        ///判断本地账户是否过期
        if let account = AccountTool.localAccount {
            params.uid = String(account.uid)
            if account.name != "" {
                idButton.setTitle(account.name, forState: .Normal)
                LoginUserTool.SaveLoginUserWith(params, success: {
                    (loginUser: LoginUser) -> Void in
                        self.idButton.setTitle(loginUser.name, forState: .Normal)
                    print("success")
                    }, failure: { (error: NSError) -> Void in
                        print(error)
                })
            } else {
                LoginUserTool.SaveLoginUserWith(params, success: {
                    (loginUser: LoginUser) -> Void in
                    print("success")
                    self.idButton.setTitle(loginUser.name, forState: .Normal)
                    }, failure: { (error: NSError) -> Void in
                        print(error)
                })
            }
        } else {
            print("token已过期")
            ShowViewTool.TokenExpired()
        }
    }
    ///初始newStatus属性
    func resetnewStatusView() {
        newStatusView = UIButton()
        newStatusView.alpha = 0.9
        newStatusView.titleLabel?.font = UIFont.systemFontOfSize(12)
        newStatusView.backgroundColor = UIColor.orangeColor()
        newStatusView.frame = CGRect(x: 0, y: 33, width: UIScreen.mainScreen().bounds.width, height: 33)
    }
}

extension HomeViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = StatusCell()
        cell.subviewFrame = subviewFrames[indexPath.row]
        
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return subviewFrames[indexPath.row].cellHeight
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subviewFrames.count
    }
    
}
