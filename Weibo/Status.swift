//
//  Status.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//


import UIKit
import YYModel

///微博模型
class Status: NSObject, YYModel {
    /// 转发数
    var reposts_count: String!
    /// 评论数
    var comments_count: String!
    /// 点赞
    var attitudes_count: String!
    
    /// 微博创建时间(来自api)
    var created_at: String!
    //    ⬇️通过计算转换为下面的显示时间
    /// 转换后的显示时间(来自api)
    var created_atLabelString: String! {
        ///创建时区
        let zone = NSTimeZone(forSecondsFromGMT: 3600*8)
        let interval = zone.secondsFromGMTForDate(NSDate())
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        let creatDate = dateFormatter.dateFromString(created_at)?.dateByAddingTimeInterval(NSTimeInterval(interval))
        
        

        
        if let time = creatDate {
            
            if time.isToday() {
                
                if time.deltaWithNow().hour >= 1 {///一小时前
                    return "\(time.deltaWithNow().hour)小时前"
                } else if time.deltaWithNow().minute >= 1 {///几分钟前
                    return "\(time.deltaWithNow().minute)分钟前"
                } else {
                    return "刚刚"
                }
            } else if time.isYesterday() {
                dateFormatter.dateFormat = "昨天 HH:mm"
                return dateFormatter.stringFromDate(time)
            } else if time.isThisYear() {
                dateFormatter.dateFormat = "MM-dd HH:mm"
                return dateFormatter.stringFromDate(time)
            } else {
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                return dateFormatter.stringFromDate(time)
            }
        }
        return "无时间"
    }
    
    /// 字符串型的微博ID
    var idstr: String!
    /// 微博正文内容
    var text: String!
    /// 微博来源(来自api) 只负责储存
    var source: String! {
        didSet {
            if let start = source.rangeOfString("\">") {
                if let end = source.rangeOfString("</a>") {
                    let range = Range<String.Index>(start: start.endIndex, end: end.startIndex)
                    let s = source.substringWithRange(range)
                    source = "来自 " + s
                }
            }
        }
        
    }
    //    ⬇️通过计算转换为下面的显示来源
    /// 转换后的显示来源
    var sourceLabelString: String! {
        
        
        return ""
    }
    /// 用户详细数据
    var user: User!
//    /// 正文配图
//    var thumbnail_pic: String?
    ///全部配图
    var pic_urls: NSArray?

    /// 转发微博
    var retweeted_status: Status?
    
    
    ///实现数组模型提供对应类转换
    static func modelContainerPropertyGenericClass() -> [NSObject : AnyObject]! {
        return ["pic_urls": Photo.self]
    }
}



extension NSDate {
    func isToday() -> Bool {
        ///创建日历
        let calendar = NSCalendar.currentCalendar()
        
        let zone = NSTimeZone(forSecondsFromGMT: 3600*8)
        let interval = zone.secondsFromGMTForDate(NSDate())
        let now = NSDate().dateByAddingTimeInterval(NSTimeInterval(interval)) //当前时间
        let nowCmps = calendar.components([.Year, .Month, .Day], fromDate: now)
        
        let selfCmps = calendar.components([.Year, .Month, .Day], fromDate: self)
        
        if nowCmps == selfCmps {
            return true
        }
        print("now = \(now)")
        return false
    }func isYesterday() -> Bool {
        
        return false
    }func isThisYear() -> Bool {
        ///创建日历
        let calendar = NSCalendar.currentCalendar()
        
        let zone = NSTimeZone(forSecondsFromGMT: 3600*8)
        let interval = zone.secondsFromGMTForDate(NSDate())
        let now = NSDate().dateByAddingTimeInterval(NSTimeInterval(interval)) //当前时间
        let nowCmps = calendar.components([.Year, .Month, .Day], fromDate: now)
        
        let selfCmps = calendar.components([.Year, .Month, .Day], fromDate: self)
        
        if nowCmps.year == selfCmps.year {
            return true
        }
        print("now = \(now)")

        return false
    }
    
    ///获得与当前时间的差距
    func deltaWithNow() -> NSDateComponents {
        let calendar = NSCalendar.currentCalendar()
        
        let zone = NSTimeZone(forSecondsFromGMT: 3600*8)
        let interval = zone.secondsFromGMTForDate(NSDate())
        let now = NSDate().dateByAddingTimeInterval(NSTimeInterval(interval)) //当前时间
        
        return calendar.components([.Hour, .Second, .Minute], fromDate: self, toDate: now, options: .WrapComponents)
        
    }
}