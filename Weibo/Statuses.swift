//
//  statuses.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//


import UIKit

class Statuses: NSObject {
    /// 转发数
    var reposts_count: String!
    /// 评论数
    var comments_count: String!
    /// 点赞
    var attitudes_count: String!
    /// 微博创建时间
    var created_at: String!
    /// 字符串型的微博ID
    var idstr: String!
    /// 微博正文内容
    var text: String!
    /// 微博来源
    var source: String!
    /// 用户详细数据
    var user: User!
    /// 正文配图
    var thumbnail_pic: String?
    /// 转发微博
    var retweeted_status: Statuses?
}
