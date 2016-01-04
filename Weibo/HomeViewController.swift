//
//  HomeViewController.swift
//  Weibo
//
//  Created by Riversideview on 15/12/24.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit
import AFNetworking
import YYModel
import SDWebImage
import MJRefresh

class HomeViewController: UITableViewController {

    /// 微博Hight数组包含了微博信息
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

    let footer = MJRefreshNormalHeader()
    func setupRefreshControl() {
        let header = MJRefreshNormalHeader { () -> Void in
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
    
    func getPastStatus() {
        let manager = AFHTTPSessionManager()
        var params = [String: AnyObject] ()
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        if subviewFrames.count > 0 {
            if let max_id = self.subviewFrames.last?.status.idstr {
                
                if let token = AccountTool.localAccount?.access_token {
                    params = [
                        "access_token": token,
                        "max_id": Int(max_id)! - 1,
                        "count": 5 //微博获取数量

                    ]
                }
            }
            
        } else if let token = AccountTool.localAccount?.access_token {
            params = [
                "access_token": token,
                "count": 5 //微博获取数量
            ]
        }
        /**
        *  获取微博信息
        */
        manager.GET(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
            if let timeline = data as? [String : AnyObject] {
                //                print(timeline)
                if let statuses = timeline["statuses"] as? [NSDictionary] {
                    var pastStatuses = [StatusCellSubviewFrame]()
                    
                    for status in statuses {
                        let currentStatus = Status.yy_modelWithDictionary(status as [NSObject : AnyObject])
                        let controller = StatusCellSubviewFrame()
                        controller.status = currentStatus
                        pastStatuses.append(controller)
                        
                    }
                    self.subviewFrames.appendContentsOf(pastStatuses)
                    self.tableView.mj_footer.endRefreshing()
                    print("完成刷新")
                    self.tableView.reloadData()
                }
                
                
            }
            }) { (_, error: NSError) -> Void in
                print("failed \(error)")
                
        }

    }
    
    //获取最新微博
    func setupStatus() {
        let manager = AFHTTPSessionManager()
        var params = [String: AnyObject] ()
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        if subviewFrames.count > 0 {
            if let since_id = self.subviewFrames.first?.status.idstr {
                if let token = AccountTool.localAccount?.access_token {
                    params = [
                        "access_token": token,
                        "since_id": since_id
                    ]
                }
            }
 
        } else if let token = AccountTool.localAccount?.access_token {
            params = [
                "access_token": token,
                "count": 5 //微博获取数量
            ]
        }
        /**
        *  获取微博信息
        */
        manager.GET(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
            if let timeline = data as? [String : AnyObject] {
//                print(timeline)
                if let statuses = timeline["statuses"] as? [NSDictionary] {
                    var newStatuses = [StatusCellSubviewFrame]()
                    
                    for status in statuses {
                        let currentStatus = Status.yy_modelWithDictionary(status as [NSObject : AnyObject])
                        let controller = StatusCellSubviewFrame()
                        controller.status = currentStatus
                        newStatuses.append(controller)
                        
                    }
                    self.subviewFrames.insertContentsOf(newStatuses, at: 0)
                    self.showNewStatusesCount(statuses.count)
                    self.tableView.mj_header.endRefreshing()
                    self.tableView.reloadData()
                }
            }
            }) { (_, error: NSError) -> Void in
                print("failed \(error)")
                self.tableView.mj_header.endRefreshing()

        }
    }
    /**
     配置NavBar
     */
    func setupNavBar() {
        /**
        创建ID按钮
        */

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
        var params = [String: AnyObject]()

        let url = "https://api.weibo.com/2/users/show.json"
        if let account = AccountTool.localAccount {
            params = [
                "access_token": account.access_token,
                "uid": String(account.uid)
            ]
            if account.name != "" {
                idButton.setTitle(account.name, forState: .Normal)
                saveLoginUserName(url, params: params)
            } else {
                saveLoginUserName(url, params: params)
            }
            
        } else {
            print("token已过期")
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

    
    func saveLoginUserName(url: String, params: [String: AnyObject]) {
        let manager = AFHTTPSessionManager()

        manager.GET(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
            if let user = data as? [String : AnyObject] {
                //                print(user)
                let loginUser = User.yy_modelWithDictionary(user as [NSObject : AnyObject])
                self.idButton.setTitle(loginUser.name, forState: .Normal)
                let account = AccountTool.localAccount!
                account.name = loginUser.name
                AccountTool.saveAccount(account)
            }
            }) { (data, error: NSError) -> Void in
                print("failed \(error) \(data)")
        }
    }
}

extension HomeViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = StatusCell()
        cell.subviewFrame = subviewFrames[indexPath.row]
        
        return cell
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return subviewFrames[indexPath.row].cellHeight
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subviewFrames.count
    }
    
}
