//
//  StatuseCell.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit
///昵称字体
let IDFont = UIFont.systemFontOfSize(16)
/// 来源
let SourceFont = UIFont.systemFontOfSize(16)
///发送时间
let TimeFont = UIFont.systemFontOfSize(16)
/// 正文
let MainFont = UIFont.systemFontOfSize(20)

class StatuseCell: UITableViewCell {
    
    ///内容区
    var topView: UIImageView!
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
    var retweetView: UIImageView!
    ///昵称
    var retweetNameButton: UIButton!
    ///内容
    var retweetMainLabel: UILabel!
    ///转发配图
    var retweetThumbnailView: UIImageView!

    
    ///底部功能区
    var toolbar: UIImageView!
    /// 转发
    var repostButton: UIButton!
    /// 评论
    var commentsButton: UIButton!
    /// 点赞
    var attitudesButton: UIButton!


    ///自动计算cell的frame并设置frame
    var controller: CellFrameController! {
        didSet {
            setupOriginalSubviewsFrames()
        }
    }
    
    /**
     获得微博数据后执行该方法设置子控件的frame
     */
    func setupOriginalSubviewsFrames() {
        let statuse = controller.statuse
        let user = controller.statuse.user

        ///内容区
        topView.frame = controller.topView
        ///头像
        iconView.sd_setImageWithURL(NSURL(string: statuse.user.profile_image_url), placeholderImage: UIImage(named: "avatar_default"))
        iconView.frame = controller.iconView
        /// 昵称
        idLabel.text = user.name
        idLabel.font = IDFont
        idLabel.frame = controller.idLabel
        /// 来源
        sourceLabel.text = statuse.source
        sourceLabel.font = SourceFont
        sourceLabel.frame = controller.sourceLabel
        ///发送时间
        timeLabel.text = statuse.created_at
        timeLabel.font = TimeFont
        timeLabel.frame = controller.timeLabel
        /// 正文
        mainLabel.text = statuse.text
        mainLabel.font = MainFont
        mainLabel.frame = controller.mainLabel
        mainLabel.numberOfLines = 0
        
        
    }
    

    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupOriginalSubviews()
//        setupRetweetSubviews()
//        setupToolbar()
    }
    
    /**
     初始化正文子控件
     */
    func setupOriginalSubviews() {
        
        ///将内容区添加到contentView
        topView = UIImageView()
        contentView.addSubview(topView)

        /// 头像
        iconView = UIImageView()
        topView.addSubview(iconView)
        /// 昵称
        idLabel = UILabel()
        topView.addSubview(idLabel)
        /// 来源
        sourceLabel = UILabel()
        topView.addSubview(sourceLabel)
        ///发送时间
        timeLabel = UILabel()
        topView.addSubview(timeLabel)
        /// 正文
        mainLabel = UILabel()
        topView.addSubview(mainLabel)
        /// 正文配图
        thumbnailView = UIImageView()
        topView.addSubview(thumbnailView)
    }

    /**
     配置转发区域子控件
     */
    func setupRetweetSubviews() {
        
        ///将转发添加到内容区
        retweetView = UIImageView()
        topView.addSubview(retweetView)
        ///昵称
        retweetNameButton = UIButton()
        retweetView.addSubview(retweetNameButton)
        ///内容
        retweetMainLabel = UILabel()
        retweetNameButton.addSubview(retweetMainLabel)
        ///转发配图
        retweetThumbnailView = UIImageView()
        retweetNameButton.addSubview(retweetThumbnailView)

    }
    
    /**
     配置工具栏子控件
     */
    func setupToolbar() {
        
        toolbar = UIImageView()
        /// 转发
        repostButton = UIButton()
        toolbar.addSubview(repostButton)
        /// 评论
        commentsButton = UIButton()
        toolbar.addSubview(commentsButton)
        /// 点赞
        attitudesButton = UIButton()
        toolbar.addSubview(attitudesButton)
        
        contentView.addSubview(toolbar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
