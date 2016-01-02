//
//  StatusCellSubviewFrame.swift
//  Weibo
//
//  Created by Riversideview on 15/12/29.
//  Copyright © 2015年 Riversideview. All rights reserved.
//
import UIKit
///view model
class StatusCellSubviewFrame: NSObject {
    
    ///内容区
    var statusView: CGRect!
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
    ///昵称+内容
    var retweetMainLabel: CGRect!
    ///转发配图
    var retweetThumbnailView: CGRect!
    
    
    ///底部评论区
    var commentView: CGRect!
    
    /// cell高度
    var cellHeight: CGFloat!
    
    
    
    ///获取到的微博属性
    var status: Status! {
        didSet {
            setupStatusViewFrames()
        }
    }
    /**
     自动计算Cell的高度以及子控件frame
     */
    func setupStatusViewFrames() {
        
        ///cell宽度
        let cellWidth: CGFloat = UIScreen.mainScreen().bounds.width
        ///statusView
        let topX: CGFloat = 0
        let topY: CGFloat = 0
        let topW: CGFloat = cellWidth
        var topH: CGFloat = 0
       
        /// 头像
        let iconX: CGFloat = cellSpacing
        let iconY: CGFloat = cellSpacing
        let iconW: CGFloat = cellWidth / 9
        let iconH: CGFloat = cellWidth / 9
        
        iconView = CGRect(x: iconX, y: iconY, width: iconW, height: iconH)

        /// 昵称
        let idSize: CGSize = (status.user.name as NSString).sizeWithAttributes([NSFontAttributeName: IDFont as AnyObject])
        let idX: CGFloat = CGRectGetMaxX(iconView) + cellSpacing
        let idY: CGFloat = CGRectGetMaxY(iconView) - iconH/2 - idSize.height
        
        idLabel = CGRect(x: idX, y: idY, width: idSize.width, height: idSize.height)
        
//        ///是否会员
//        let vipX: CGFloat = idX + idSize.width + 2 //左右边距
//        let vipY: CGFloat = cellSpacing
//        let vipW: CGFloat = 12
//        let vipH: CGFloat = 12
//        
//        vipView = CGRect(x: vipX, y: vipY, width: vipW, height: vipH)
       
        ///发送时间
        let timeX: CGFloat = idX
        let timeY: CGFloat = iconH/2 + cellSpacing + 2
        let timeSize: CGSize = (status.created_atLabelString as NSString).sizeWithAttributes([NSFontAttributeName: TimeFont as AnyObject])
        timeLabel = CGRect(x: timeX, y: timeY, width: timeSize.width, height: timeSize.height)
        
        /// 来源
        let sourceX: CGFloat = timeX + timeSize.width + cellSpacing
        let sourceY: CGFloat = timeY
        let sourceSize: CGSize = (status.source as NSString).sizeWithAttributes([NSFontAttributeName: SourceFont as AnyObject])

        sourceLabel = CGRect(x: sourceX, y: sourceY, width: sourceSize.width, height: sourceSize.height)
        
        /// 正文
        let mainX: CGFloat = iconX
        let mainY: CGFloat = CGRectGetMaxY(iconView) + cellSpacing
        let mainText = NSAttributedString(string: status.text, attributes: [NSFontAttributeName: MainFont as AnyObject])
        let mainSize = mainText.boundingRectWithSize(CGSize(width: cellWidth - cellSpacing * 2, height: CGFloat.max), options: .UsesLineFragmentOrigin, context: nil)
        
        mainLabel = CGRect(x: mainX, y: mainY, width: mainSize.width, height: mainSize.height)

        /// 正文配图
        if status.pic_urls?.count > 0 {
            let thumbnailX: CGFloat = mainX
            let thumbnailY: CGFloat = CGRectGetMaxY(mainLabel) + cellSpacing
            let imageCount = status.pic_urls?.count
            
            let thumbnailW: CGFloat = cellWidth - cellSpacing * 2
            var thumbnailH: CGFloat = cellWidth / 2

            if imageCount == 1 {
                thumbnailH = thumbnailW / 3
            } else if imageCount == 2 {
                thumbnailH = (thumbnailW - imageSpacing * 2) / 2.5
            } else if imageCount == 3 {
                thumbnailH = (thumbnailW - imageSpacing * 2) / 3
            } else if imageCount == 4 {
                thumbnailH = ((thumbnailW - imageSpacing * 2) / 2.8) * 2 + imageSpacing
            } else if imageCount > 4 {
                if imageCount > 6 { //共三行
                    thumbnailH = (thumbnailW - imageSpacing * 2) / 3 * 3 + imageSpacing * 2
                } else { //共两行
                    thumbnailH = (thumbnailW - imageSpacing * 2) / 3 * 2 + imageSpacing
                }
            }

            thumbnailView = CGRect(x: thumbnailX, y: thumbnailY, width: thumbnailW, height: thumbnailH)
            
            
            topH += CGRectGetMaxY(thumbnailView)  + cellSpacing
        } else if status.retweeted_status == nil && status.pic_urls?.count == 0 {
            topH = CGRectGetMaxY(mainLabel) + cellSpacing
        }
        
        ///转发
        if let retweeted_status = status.retweeted_status {
            ///昵称+内容
            let retweetMainX: CGFloat = cellSpacing
            let retweetMainY: CGFloat = cellSpacing
            

            ///判断转发微博是否被删除
            if retweeted_status.user != nil {
                let retweetMainText = "@" + retweeted_status.user.name + "：" + retweeted_status.text
                let retweetMainAText = NSAttributedString(string: retweetMainText, attributes: [NSFontAttributeName: RetweetMainFont as AnyObject])
                let retweetMainSize = retweetMainAText.boundingRectWithSize(CGSize(width: cellWidth - cellSpacing * 2, height: CGFloat.max), options: .UsesLineFragmentOrigin, context: nil).size

                retweetMainLabel = CGRect(x: retweetMainX, y: retweetMainY, width: retweetMainSize.width, height: retweetMainSize.height)
            } else {
                let retweetMainText = retweeted_status.text
                let retweetMainAText = NSAttributedString(string: retweetMainText, attributes: [NSFontAttributeName: RetweetMainFont as AnyObject])
                let retweetMainSize = retweetMainAText.boundingRectWithSize(CGSize(width: cellWidth - cellSpacing * 2, height: CGFloat.max), options: .UsesLineFragmentOrigin, context: nil).size
                
                retweetMainLabel = CGRect(x: retweetMainX, y: retweetMainY, width: retweetMainSize.width, height: retweetMainSize.height)
            }
            
            ///转发配图
            if retweeted_status.pic_urls?.count > 0 {
                
                let imageCount = retweeted_status.pic_urls?.count

                
                let retweetThumbnailX: CGFloat = retweetMainX
                let retweetThumbnailY: CGFloat = CGRectGetMaxY(retweetMainLabel) + cellSpacing
                let retweetThumbnailW: CGFloat = cellWidth - cellSpacing * 2
                var retweetThumbnailH: CGFloat = cellWidth / 2
                
                if imageCount == 1 {
                    retweetThumbnailH = retweetThumbnailW / 2
                } else if imageCount == 2 {
                    retweetThumbnailH = (retweetThumbnailW - imageSpacing * 2) / 2.5
                } else if imageCount == 3 {
                    retweetThumbnailH = (retweetThumbnailW - imageSpacing * 2) / 3
                } else if imageCount == 4 {
                    retweetThumbnailH = ((retweetThumbnailW - imageSpacing * 2) / 2.8) * 2 + imageSpacing

                } else if imageCount > 4 {
                    if imageCount > 6 { //共三行
                        retweetThumbnailH = (retweetThumbnailW - imageSpacing * 2) / 3 * 3 + imageSpacing * 2
                    } else { //共两行
                        retweetThumbnailH = (retweetThumbnailW - imageSpacing * 2) / 3 * 2 + imageSpacing
                    }
                }

                
                retweetThumbnailView = CGRect(x: retweetThumbnailX, y: retweetThumbnailY, width: retweetThumbnailW, height: retweetThumbnailH)
                
                
                
                
                
                ///转发内容区(有图)
                let retweetX: CGFloat = 0
                let retweetY: CGFloat = CGRectGetMaxY(mainLabel) + cellSpacing
                let retweetW: CGFloat = cellWidth
                let retweetH: CGFloat = cellSpacing + CGRectGetMaxY(retweetThumbnailView)
                
                retweetView = CGRect(x: retweetX, y: retweetY, width: retweetW, height: retweetH)
                
            } else {
                ///转发内容区(无图)
                let retweetX: CGFloat = 0
                let retweetY: CGFloat = CGRectGetMaxY(mainLabel) + cellSpacing
                let retweetW: CGFloat = cellWidth
                let retweetH: CGFloat = CGRectGetMaxY(retweetMainLabel) + cellSpacing
                
                retweetView = CGRect(x: retweetX, y: retweetY, width: retweetW, height: retweetH)
            }
            
            ///内容区(有转发)
            
            topH += CGRectGetMaxY(mainLabel) + retweetView.height + cellSpacing
            
            statusView = CGRect(x: topX, y: topY, width: topW, height: topH)
        } else {
            ///内容区(无转发)
            
            
            statusView = CGRect(x: topX, y: topY, width: topW, height: topH)
            
        }
        ///底部评论区
        let toolX: CGFloat = 0
        let toolY: CGFloat = topH
        let toolW: CGFloat = cellWidth
        let toolH: CGFloat = 35
        
        commentView = CGRect(x: toolX, y: toolY, width: toolW, height: toolH)
        cellHeight = CGRectGetMaxY(commentView) - 1
        
    }
    

}



