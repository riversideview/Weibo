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
    var controllerArray = [CellFrameController]()

    /// 顶部IDbutton
    let idButton = IDButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        setupStatus()
        self.tableView.backgroundColor = UIColor(red: 200, green: 200, blue: 200, alpha: 1)
        self.tableView.separatorStyle = .None
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
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
        if let token = AccountTool.localAccount?.access_token {
            params = [
                
                "access_token": token,
                
                "count": 20 //微博获取数量
                
        
            ]
        }
        /**
        *  获取微博信息
        */
        manager.GET(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
            if let timeline = data as? [String : AnyObject] {
                print(timeline)
                if let statuses = timeline["statuses"] as? [NSDictionary] {
                    for status in statuses {

                        let currentStatus = Status.yy_modelWithDictionary(status as [NSObject : AnyObject])

                        let controller = CellFrameController()
                        controller.status = currentStatus
                        print(controller.status.pic_urls?.count)
                        self.controllerArray.append(controller)
                        
                    }
                    self.tableView.reloadData()
                    
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
        //添加监听标题监听
//        self.navigationItem.addObserver(self, forKeyPath: "title", options: .New, context: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = StatusCell(style: .Default, reuseIdentifier: "Cell")
        cell.controller = self.controllerArray[indexPath.row]
        
        return cell
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return controllerArray[indexPath.row].cellHeight
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllerArray.count
    }
    
    
    
    
}
