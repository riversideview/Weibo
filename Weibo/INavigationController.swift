//

//  INavigationController.swift
//  Weibo
//
//  Created by Riversideview on 15/12/26.
//  Copyright © 2015年 Riversideview. All rights reserved.
//
import UIKit

class INavigationController: UINavigationController {
    
    
    override class func initialize() {
        setupNavBarTheme()
        setupNavButtonItemTheme()
    }
    
//    override init(rootViewController: UIViewController) {
//        super.init(rootViewController: rootViewController)

//
//        
//    }
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    //设置nav按钮
    class func setupNavButtonItemTheme() {
        
//        item.setBackgroundImage(UIImage(named: "navigationbar_button_right_background"), forState: .Normal, barMetrics: .Default)
//        item.setBackgroundImage(UIImage(named: "navigationbar_button_right_background_pushed"), forState: .Highlighted, barMetrics: .Default)
        
        let item = UIBarButtonItem.appearance()
        //首页
        var mainAttributes = [String: AnyObject]()
        mainAttributes[NSForegroundColorAttributeName] = UIColor.orangeColor()
        mainAttributes[NSShadowAttributeName] = nil
        mainAttributes[NSFontAttributeName] = UIFont.systemFontOfSize(20)
        item.setTitleTextAttributes(mainAttributes, forState: .Normal)

        
        var postAttributes = [String: AnyObject]()
        postAttributes[NSForegroundColorAttributeName] = UIColor.purpleColor()
        postAttributes[NSShadowAttributeName] = nil
        postAttributes[NSFontAttributeName] = UIFont.systemFontOfSize(20)
        item.setTitleTextAttributes(postAttributes, forState: UIControlState.Disabled)

        
    }
    
    //设置nav主题
    class func setupNavBarTheme() {
        let navBar = UINavigationBar.appearance()
        
        navBar.setBackgroundImage(UIImage(named: "navigationbar_background_os7"), forBarMetrics: .Default)
        
        var attributes = [String: AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.purpleColor()
        attributes[NSShadowAttributeName] = nil
        attributes[NSFontAttributeName] = UIFont.systemFontOfSize(20)
        navBar.titleTextAttributes = attributes
        
        
    }
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
