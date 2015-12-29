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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        setupStatuses()
    }
    let idButton = IDButton()
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        dispatch_async(dispatch_get_main_queue()) {
            
        }
        
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
    /// 用于展示的微博
    var statusesArray = [Statuses?]()

    //获取最新微博
    func setupStatuses() {
        let manager = AFHTTPSessionManager()
        var params = [String: AnyObject] ()
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        if let token = AccountTool.localAccount?.access_token {
            params = [
                
                "access_token": token,
                "count": 1
                
            ]
        }

        

        
        /**
        *  获取微博信息
        */
        manager.GET(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
            if let timeline = data as? [String : AnyObject] {
                if let statuses = timeline["statuses"] as? [AnyObject] {
                    
                    for statuse in statuses {
                        print(statuse)
                        let currentstatuse = Statuses.yy_modelWithJSON(statuse)
                        print(currentstatuse.text)
                        print(currentstatuse.created_at)
                        print(currentstatuse.idstr)
                        print(currentstatuse.comments_count)
                        print(currentstatuse.attitudes_count)
                        print(currentstatuse.reposts_count)
                        print(currentstatuse.user.name)
                        print(currentstatuse.user.idstr)
                        print(currentstatuse.user.profile_image_url)
                        self.statusesArray.append(currentstatuse)
                        self.tableView.reloadData()
                    }
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
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")

        if let statuse = statusesArray[indexPath.row] {
            cell.textLabel?.text = statuse.text
            cell.detailTextLabel?.text = statuse.user.name
            cell.imageView?.sd_setImageWithURL(NSURL(string: statuse.user.profile_image_url))
            
        }
        
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusesArray.count
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.purpleColor()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
