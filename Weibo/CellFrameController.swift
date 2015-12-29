//
//  CellFrameController.swift
//  Weibo
//
//  Created by Riversideview on 15/12/29.
//  Copyright © 2015年 Riversideview. All rights reserved.
//
import UIKit

class CellFrameController: NSObject {
    
    ///内容区
    var topView: CGRect!
    /// 头像
    var iconView: CGRect!
    /// 昵称
    var idLabel: CGRect!
    /// 来源
    var sourceLabel: CGRect!
    ///发送时间
    var timeLabel: CGRect!
    /// 正文
    var mainLabel: CGRect!
    /// 正文配图
    var thumbnailView: CGRect!
    ///是否会员
    var vipView: CGRect!
    
    ///转发内容区
    var retweetView: CGRect!
    ///昵称
    var retweetNameButton: CGRect!
    ///内容
    var retweetMainLabel: CGRect!
    ///转发配图
    var retweetThumbnailView: CGRect!
    
    
    ///底部功能区
    var toolbar: CGRect!
    /// 转发
    var repostButton: CGRect!
    /// 评论
    var commentsButton: CGRect!
    /// 点赞
    var attitudesButton: CGRect!
    /// cell高度
    var cellHeight: CGFloat!
    ///statuse属性
    var statuse: Statuses! {
        didSet {
            setupTopViewFrames()
            print("cellHeight = \(cellHeight)")
        }
    }
    /**
     自动计算Cell的高度以及子控件frame
     */
    func setupTopViewFrames() {
        
        ///cell宽度
        let cellWidth: CGFloat = UIScreen.mainScreen().bounds.width
        ///cell外边缘
        let cellEdge: CGFloat = 5
       
        /// 头像
        let iconX: CGFloat = cellEdge
        let iconY: CGFloat = cellEdge
        let iconW: CGFloat = cellWidth / 12
        let iconH: CGFloat = cellWidth / 12
        
        iconView = CGRect(x: iconX, y: iconY, width: iconW, height: iconH)
        
        /// 昵称
        let idX: CGFloat = iconX + iconW + cellEdge
        let idY: CGFloat = cellEdge
        let idSize: CGSize = (statuse.user.name as NSString).sizeWithAttributes([NSFontAttributeName: IDFont as AnyObject])
        
        idLabel = CGRect(x: idX, y: idY, width: idSize.width, height: idSize.height)
        
        ///是否会员
        let vipX: CGFloat = idX + idSize.width + 2 //左右边距
        let vipY: CGFloat = cellEdge
        let vipW: CGFloat = 12
        let vipH: CGFloat = 12
        
        vipView = CGRect(x: vipX, y: vipY, width: vipW, height: vipH)
        
        ///发送时间
        let timeX: CGFloat = idX
        let timeY: CGFloat = idY + idSize.height + 2 //上下边距
        let timeSize: CGSize = (statuse.created_at as NSString).sizeWithAttributes([NSFontAttributeName: TimeFont as AnyObject])
        timeLabel = CGRect(x: timeX, y: timeY, width: timeSize.width, height: timeSize.height)
        
        /// 来源
        let sourceX: CGFloat = timeX + timeSize.width + 2
        let sourceY: CGFloat = timeY
        let sourceSize: CGSize = (statuse.source as NSString).sizeWithAttributes([NSFontAttributeName: SourceFont as AnyObject])

        sourceLabel = CGRect(x: sourceX, y: sourceY, width: sourceSize.width, height: sourceSize.height)
        
        /// 正文
        let mainX: CGFloat = iconX
        let mainY: CGFloat = cellEdge + iconH + 10
        let mainText = NSAttributedString(string: statuse.text, attributes: [NSFontAttributeName: MainFont as AnyObject])
        let mainSize = mainText.boundingRectWithSize(CGSize(width: cellWidth - cellEdge * 2, height: CGFloat.max), options: .UsesLineFragmentOrigin, context: nil)
        print(mainSize)
        
        mainLabel = CGRect(x: mainX, y: mainY, width: mainSize.width, height: mainSize.height)
        
//        /// 正文配图
//        thumbnailView =
            
        ///内容区
        let topX: CGFloat = 0
        let topY: CGFloat = 0
        let topW: CGFloat = cellWidth
        let topH: CGFloat = cellEdge + CGRectGetMaxY(mainLabel)
        
        topView = CGRect(x: topX, y: topY, width: topW, height: topH)
        
        cellHeight = topView.height
    }
    

}



