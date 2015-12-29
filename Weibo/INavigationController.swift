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
    //设置nav按钮
    class func setupNavButtonItemTheme() {
        let item = UIBarButtonItem.appearance()
//        item.setBackgroundImage(UIImage(named: "navigationbar_button_right_background"), forState: .Normal, barMetrics: .Default)
//        item.setBackgroundImage(UIImage(named: "navigationbar_button_right_background_pushed"), forState: .Highlighted, barMetrics: .Default)
        var attributes = [String: AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.orangeColor()
        attributes[NSShadowAttributeName] = nil
        attributes[NSFontAttributeName] = UIFont.systemFontOfSize(20)
        item.setTitleTextAttributes(attributes, forState: .Normal)
    }
    //设置nav主题
    class func setupNavBarTheme() {
        let navBar = UINavigationBar.appearance()
        
        navBar.setBackgroundImage(UIImage(named: "navigationbar_background_os7"), forBarMetrics: .Default)
        
        var attributes = [String: AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.purpleColor()
        attributes[NSShadowAttributeName] = nil
        attributes[NSFontAttributeName] = UIFont.systemFontOfSize(22)
        navBar.titleTextAttributes = attributes
    }
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    
    
    
}
