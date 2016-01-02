//
//  Account.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import Foundation
class Account: NSObject, NSCoding {
    /* 示例返回数据
    {
    "access_token" = "2.00yIhneCv1XhgBb848c98555u3vpxB";
    "expires_in" = 157679999;
    "remind_in" = 157679999;
    uid = 2435163024;
    }
    */
    override var description: String {
        return "dddd"
    }

    var access_token: String = ""
    var expires_in: Int = 0
    var remind_in: Int = 0
    var uid: Int64 = 0
    var expiresTime: NSDate!
    var since_id: Int = 0
    ///登陆后的用户名
    var name: String!
    
    init(account: [String : AnyObject]) {
        super.init()
        
        ///通过字典给自身赋值
        self.setValuesForKeysWithDictionary(account)
        expiresTime = NSDate().dateByAddingTimeInterval(Double(expires_in))
//        access_token = account["access_token"] as! String
//        expires_in = account["expires_in"] as! Int
//        remind_in = (account["remind_in"] as! NSString).intValue
//        uid = (account["uid"] as! NSString).intValue
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeInteger(expires_in, forKey: "expires_in")
        aCoder.encodeInteger(remind_in, forKey: "remind_in")
        aCoder.encodeInt64(uid, forKey: "uid")
        aCoder.encodeInteger(since_id, forKey: "since_id")
        aCoder.encodeObject(expiresTime, forKey: "expiresTime")
        aCoder.encodeObject(name, forKey: "name")
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        
        access_token = aDecoder.decodeObjectForKey("access_token") as! String
        expires_in = aDecoder.decodeIntegerForKey("expires_in")
        remind_in = aDecoder.decodeIntegerForKey("remind_in")
        uid = aDecoder.decodeInt64ForKey("uid")
        since_id = aDecoder.decodeIntegerForKey("since_id")
        expiresTime = aDecoder.decodeObjectForKey("expiresTime") as! NSDate
        name = aDecoder.decodeObjectForKey("name") as! String
    }
    
    
    
    
    

    
}
