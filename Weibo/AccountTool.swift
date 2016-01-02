//
//  AccountTool.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

//账号保存地址
let AccountSavePath: String! = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last?.URLByAppendingPathComponent("account.data").path

import UIKit
//账号工具管理
class AccountTool: NSObject {
    //保存账户至本地目录
    class func saveAccount(account: Account) {
        //执行归档并打印结果
        print(NSKeyedArchiver.archiveRootObject(account, toFile: AccountSavePath!))
    }
    
    //获取本地账户文件的信息
    static var localAccount: Account? {
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(AccountSavePath) as? Account {

            let expiresTime = account.expiresTime
            if NSDate().compare(expiresTime) == .OrderedAscending {
//                print("expiresTime > now")
//                print("现在\(NSDate())")
//                print("过期时间 \(expiresTime)")
//                print("")
//                print("")
//                print(account.uid)
                return account
            }
        }
//        print("localAccount is nil")
        return nil
    }
    
    
}
