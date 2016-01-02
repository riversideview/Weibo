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


class HomeViewController: UITableViewController {

    /// 微博Hight数组包含了微博信息
    var subviewFrames = [StatusCellSubviewFrame]()

    /// 顶部IDbutton
    let idButton = IDButton()
    
    let refresh = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        setupStatus()
        setupIDButton()

        
    }
    var newStatusView: UIButton!
    
    ///显示新微博数量
    func showNewStatusesCount(count: Int) {
        newStatusView = UIButton()
        newStatusView.backgroundColor = UIColor.orangeColor()
        newStatusView.frame = CGRect(x: 0, y: 33, width: UIScreen.mainScreen().bounds.width, height: 33)
        self.navigationController?.view.insertSubview(newStatusView, belowSubview: self.navigationController!.navigationBar)
        
        count > 0 ? newStatusView.setTitle("\(count)条新微博", forState: .Normal) : newStatusView.setTitle("暂无新微博", forState: .Normal)
            
        UIView.animateWithDuration(0.7, animations: {
                self.newStatusView.transform = CGAffineTransformMakeTranslation(0, 34)
            }, completion: { finished in
                UIView.animateWithDuration(0.7, delay: 2, options: .OverrideInheritedCurve, animations: { () -> Void in
                        self.newStatusView.alpha = 0
                    }, completion: {(_) -> Void in
                        self.newStatusView.removeFromSuperview()
                        self.newStatusView = nil
                })
        })
        
        
    }
    func idButtonClick() {
        idButton.click()

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
                "count": 10 //微博获取数量
            ]
        }
        /**
        *  获取微博信息
        */
        manager.GET(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
            if let timeline = data as? [String : AnyObject] {
//                print(timeline)
                if let statuses = timeline["statuses"] as? [NSDictionary] {
                    var controllers = [StatusCellSubviewFrame]()

                    for status in statuses {
                        let currentStatus = Status.yy_modelWithDictionary(status as [NSObject : AnyObject])
                        let controller = StatusCellSubviewFrame()
                        controller.status = currentStatus
                        controllers.append(controller)
                        
                    }
                    var newStatuses = [StatusCellSubviewFrame]()
                    newStatuses += controllers

                    self.subviewFrames.insertContentsOf(newStatuses, at: 0)
                    self.showNewStatusesCount(statuses.count)
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                    
                }
          
                
            }
            }) { (_, error: NSError) -> Void in
                print("failed \(error)")

        }
    }
    /**
     配置NavBar
     */
    func setupNavBar() {
        /**
        创建ID按钮
        */
        self.idButton.setTitle(self.title, forState: .Normal)
        self.idButton.addTarget(self, action: "idButtonClick", forControlEvents: .TouchUpInside)
        self.navigationItem.titleView = self.idButton
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.addIconWithItem(image: "navigationbar_friendattention", highlight: "navigationbar_friendattention_highlighted", target: self, selector: "friendattention")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.addIconWithItem(image: "navigationbar_icon_radar", highlight: "navigationbar_icon_radar_highlighted", target: self, selector: "radar")
        self.navigationController?.navigationBar.barStyle = .Default

        //添加刷新按钮
        refresh.beginRefreshing()
        refresh.addTarget(self, action: "setupStatus", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refresh)
        
        
        //去除分割
        self.tableView.separatorStyle = .None
    }
    
    ///初始化顶部IDButton内容
    func setupIDButton() {
        
        let manager = AFHTTPSessionManager()
        var params = NSMutableDictionary()
        
        let url = "https://api.weibo.com/2/users/show.json"
        if let account = AccountTool.localAccount {
            params = [
                "access_token": account.access_token,
                "uid": Int(AccountTool.localAccount!.uid)
            ]
            if account.name != nil {
                self.idButton.setTitle(account.name, forState: .Normal)
            } else {
                manager.GET(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
                    if let user = data as? [String : AnyObject] {
                        //                print(user)
                        let loginUser = User.yy_modelWithDictionary(user as [NSObject : AnyObject])
                        self.idButton.setTitle(loginUser.name, forState: .Normal)
                        let account = AccountTool.localAccount!
                        account.name = loginUser.name
                        print(NSKeyedArchiver.archiveRootObject(account, toFile: AccountSavePath))
                        
                    }
                    }) { (data, error: NSError) -> Void in
                        print("failed \(error) \(data)")
                }
            }
            
        } else {
            print("token已过期")
        }
        /**
        *  获取微博信息
        */
        
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
