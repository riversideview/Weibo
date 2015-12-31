//
//  StatusView.swift
//  Weibo
//
//  Created by Riversideview on 15/12/31.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class StatusView: UIImageView {
    
    var controller: CellFrameController! {
        didSet {
            setupSubviewsFrames()
        }
    }
    /// 头像
    var iconView: UIImageView!
    /// 昵称
    var idLabel: UILabel!
    /// 来源
    var sourceLabel: UILabel!
    ///发送时间
    var timeLabel: UILabel!
    /// 正文
    var mainLabel: UILabel!
    /// 正文配图
    var thumbnailView: UIImageView!
    ///是否会员
    var vipView: UIImageView!
    
    
    
    ///转发内容区
    var retweetView: RetweetView!
    

 
    convenience init() {
        self.init(frame: CGRectZero)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOriginalSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     初始化正文子控件
     */
    func setupOriginalSubviews() {
        

        
        self.image = UIImage.resizeImageWithName(image: "timeline_card_background")
        self.highlightedImage = UIImage.resizeImageWithName(image: "timeline_card_background_highlighted")

        iconView = UIImageView()
        iconView.clipsToBounds = true
        self.addSubview(iconView)
        /// 昵称
        idLabel = UILabel()
        idLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(idLabel)
        /// 来源
        sourceLabel = UILabel()
        sourceLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(sourceLabel)
        ///发送时间
        timeLabel = UILabel()
        timeLabel.textColor = UIColor(red: 227/255, green: 133/255, blue: 21/255, alpha: 1)
        timeLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(timeLabel)
        /// 正文
        mainLabel = UILabel()
        mainLabel.font = MainFont
        mainLabel.numberOfLines = 0
        mainLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(mainLabel)
        /// 正文配图
        thumbnailView = UIImageView()
        self.addSubview(thumbnailView)
        
        ///将转发区域添加到内容区
        retweetView = RetweetView()
        self.addSubview(retweetView)

    }
    /**
     获得微博数据后执行该方法设置原创内容子控件的frame
     */
    func setupSubviewsFrames() {
        let status = controller.status
        let user = controller.status.user
        
        ///内容区
        self.frame = controller.statusView
        
        ///头像
        iconView.sd_setImageWithURL(NSURL(string: status.user.profile_image_url), placeholderImage: UIImage(named: "avatar_default"))
        iconView.frame = controller.iconView
        iconView.layer.cornerRadius = iconView.frame.width/2
        /// 昵称
        idLabel.text = user.name
        idLabel.font = IDFont
        idLabel.frame = controller.idLabel
        
        ///发送时间
        timeLabel.text = status.created_atLabelString
        timeLabel.font = TimeFont
        ///时间流逝需不停根据时间内容计算frame
        let timeX: CGFloat = idLabel.frame.origin.x
        let timeY: CGFloat = iconView.frame.height/2 + cellSpacing + 2
        let timeSize: CGSize = (status.created_atLabelString as NSString).sizeWithAttributes([NSFontAttributeName: TimeFont as AnyObject])
        let timeLabelFrame = CGRect(x: timeX, y: timeY, width: timeSize.width, height: timeSize.height)
        timeLabel.frame = timeLabelFrame
        
        /// 来源
        sourceLabel.text = status.source
        sourceLabel.font = SourceFont
        ///根据时间上方内容的变化更新资深frame
        let sourceX: CGFloat = timeX + timeSize.width + cellSpacing
        let sourceY: CGFloat = timeY
        let sourceSize: CGSize = (status.source as NSString).sizeWithAttributes([NSFontAttributeName: SourceFont as AnyObject])
        
        let sourceLabelFrame = CGRect(x: sourceX, y: sourceY, width: sourceSize.width, height: sourceSize.height)
        sourceLabel.frame = sourceLabelFrame
        
        
        /// 正文
        mainLabel.text = status.text
        mainLabel.frame = controller.mainLabel
        
        if status.thumbnail_pic != nil {
            thumbnailView.frame = controller.thumbnailView
            thumbnailView.sd_setImageWithURL(NSURL(string: status.thumbnail_pic!), placeholderImage: UIImage(named: "timeline_image_placeholder"))
        }
        
        ///传入frame
        retweetView.controller = controller

        
    }

    
    



}
