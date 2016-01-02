//
//  MainTabBarViewController.swift
//  Weibo
//
//  Created by Riversideview on 15/12/24.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    var customTabBar: CustomTabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupAllChildViewController()

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        for view in self.tabBar.subviews {
            if view.isKindOfClass(UIControl) {
                view.removeFromSuperview()
            }
        }
    }
    func setupTabBar() {
        customTabBar = CustomTabBar(frame: self.tabBar.bounds)
        customTabBar.delegate = self
        self.tabBar.addSubview(customTabBar)
    }
    
    func setupAllChildViewController() {
        
        let home = HomeViewController()
        self.addChildViewController(home)
        addChildViewController(home, name: "首页", image: "tabbar_home", selectImage: "tabbar_home_selected")
        home.tabBarItem.badgeValue = "99+"
        
        let messages = MessagesViewController()
        self.addChildViewController(messages)
        addChildViewController(messages, name: "消息", image: "tabbar_message_center", selectImage: "tabbar_message_center_selected")
        messages.tabBarItem.badgeValue = "66+"
 
        
        let discover = DiscoverViewController()
        self.addChildViewController(discover)
        addChildViewController(discover, name: "发现", image: "tabbar_discover", selectImage: "tabbar_discover_selected")
        discover.tabBarItem.badgeValue = "66+"

        let me = MeViewController()
        self.addChildViewController(me)
        addChildViewController(me, name: "我", image: "tabbar_profile", selectImage: "tabbar_profile_selected")
        me.tabBarItem.badgeValue = "66+"
        

    }

    func addChildViewController(viewController: UIViewController, name: String, image: String, selectImage: String) {
        viewController.title = name
        viewController.tabBarItem.image = UIImage(named: image)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImage)
        let nav = INavigationController(rootViewController: viewController)
        self.addChildViewController(nav)
        customTabBar.addTabBarButtonWithItem(viewController.tabBarItem)
    }

    
}
extension MainTabBarViewController: CustomTabBarDelegate {
    
    func didSelectButtonFrom(toint: Int) {
        self.selectedIndex = toint
    }
}
