//
//  AccountTool.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

//账号保存地址
let accountSavePath: String! = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last?.URLByAppendingPathComponent("account.data").path

import UIKit
//账号工具管理
class AccountTool: NSObject {
    //保存账户至本地目录
    class func saveAccount(account: [String: AnyObject]) {
        let currentAccount = Account(account: account)
        
        //执行归档并打印结果
        print(NSKeyedArchiver.archiveRootObject(currentAccount, toFile: accountSavePath!))
    }
    
    //获取本地账户文件的信息
    static var localAccount: Account? {
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountSavePath) as? Account {
            let expiresTime = account.expiresTime
            if NSDate().compare(expiresTime) == .OrderedAscending {
                print("expiresTime > now")
                print(NSDate())
                print(expiresTime)
                return account
            }
        }
        print("localAccount is nil")
        return nil
    }
    
    
}
