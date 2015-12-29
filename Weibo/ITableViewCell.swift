//
//  ITableViewCell.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class ITableViewCell: UITableViewCell {
    
    ///内容区
    weak var topView: UIImageView!
    /// 头像
    weak var iconView: UIImageView!
    /// 昵称
    weak var idLabel: UILabel!
    /// 来源
    weak var sourceLabel: UILabel!
    ///发送时间
    weak var timeLabel: UILabel!
    /// 正文
    weak var mainLabel: UILabel!
    /// 正文配图
    weak var thumbnailView: UIImageView!
    
    ///转发内容区
    weak var retweetView: UIImageView!
    ///昵称
    weak var retweetNameButton: UIButton!
    ///内容
    weak var retweetMainLabel: UILabel!
    ///转发配图
    weak var retweetThumbnailView: UIImageView!

    
    ///底部功能区
    weak var toolbar: UIImageView!
    /// 转发
    weak var repostButton: UIButton!
    /// 评论
    weak var commentsButton: UIButton!
    /// 点赞
    weak var attitudesButton: UIButton!



    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupOriginalSubviews()
        setupRetweetSubviews()
        setupToolbar()
    }
    /**
     配置正文子控件
     */
    func setupOriginalSubviews() {
        
        ///将内容区添加到contentView
        topView = UIImageView()
        self.contentView.addSubview(topView)

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
        self.topView.addSubview(retweetView)
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
        
        self.contentView.addSubview(toolbar)
    }
    
    
    
    
    
    
    
    
    
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
