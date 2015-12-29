//
//  WeiboTool.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class WeiboTool: NSObject {
    
    ///根据版本选择ViewController
    class func chooseViewController() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let localVersion = userDefaults.objectForKey("CFBundleVersion") as? String
        let latestVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        print("latestVersion = \(latestVersion)")
        print("localVersion  = \(localVersion)")
        if localVersion != latestVersion {
            UIApplication.sharedApplication().keyWindow?.rootViewController = NewFeatureViewController()
            userDefaults.setObject(latestVersion, forKey: "CFBundleVersion")
        } else {
            UIApplication.sharedApplication().keyWindow?.rootViewController = MainTabBarViewController()
        }
    }
}
