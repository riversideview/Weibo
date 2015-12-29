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
    var expires_in: Int32 = 0
    var remind_in: Int32 = 0
    var uid: Int32 = 0
    var expiresTime: NSDate = NSDate()
    
    init(account: [String : AnyObject]) {
        super.init()
        self.setValuesForKeysWithDictionary(account)
        self.expiresTime = NSDate().dateByAddingTimeInterval(Double(self.expires_in))
//        self.access_token = account["access_token"] as! String
//        self.expires_in = account["expires_in"] as! Int
//        self.remind_in = (account["remind_in"] as! NSString).intValue
//        self.uid = (account["uid"] as! NSString).intValue
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.access_token, forKey: "access_token")
        aCoder.encodeInt32(self.expires_in, forKey: "expires_in")
        aCoder.encodeInt32(self.remind_in, forKey: "remind_in")
        aCoder.encodeInt32(self.uid, forKey: "uid")
        aCoder.encodeObject(self.expiresTime, forKey: "expiresTime")
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.access_token = aDecoder.decodeObjectForKey("access_token") as! String
        self.expires_in = aDecoder.decodeIntForKey("expires_in")
        self.remind_in = aDecoder.decodeIntForKey("remind_in")
        self.uid = aDecoder.decodeIntForKey("uid")
        self.expiresTime = aDecoder.decodeObjectForKey("expiresTime") as! NSDate
    }
    
    
    
    
    

    
}
