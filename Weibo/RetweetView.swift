//
//  RetweetView.swift
//  Weibo
//
//  Created by Riversideview on 15/12/31.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class RetweetView: UIImageView {
    
    var status: Status! {
        didSet {
            
        }
    }
    var controller: CellFrameController! {
        didSet {
            setupSubviewsFramesFrames()
        }
    }
    ///昵称+内容
    var retweetMainLabel: UILabel!
    ///转发配图
    var retweetThumbnailView: UIImageView!

    convenience init() {
        self.init(frame: CGRectZero)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRetweetSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     配置转发区域子控件
     */
    func setupRetweetSubviews() {
        
        ///将转发添加到内容区

        self.image = UIImage.resizeImageWithName(image: "timeline_retweet_background")

        ///昵称+内容
        retweetMainLabel = UILabel()
        retweetMainLabel.font = RetweetMainFont
        retweetMainLabel.numberOfLines = 0
        retweetMainLabel.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        self.addSubview(retweetMainLabel)
        
        ///转发配图
        retweetThumbnailView = UIImageView()
        self.addSubview(retweetThumbnailView)
        
    }
    
    /**
     获得微博数据后执行该方法设置转发内容子控件的frame
     */
    func setupSubviewsFramesFrames() {
        if let retweet = controller.status.retweeted_status {
            ///昵称+内容
            retweetMainLabel.frame = controller.retweetMainLabel
            let retweetMainText = "@" + retweet.user.name + "：" + retweet.text
            retweetMainLabel.text = retweetMainText
            if let thumbnail_pic = retweet.thumbnail_pic {
                ///转发配图
                retweetThumbnailView.frame = controller.retweetThumbnailView
                retweetThumbnailView.sd_setImageWithURL(NSURL(string: thumbnail_pic), placeholderImage: UIImage(named: "timeline_image_placeholder"))
            } else {
                retweetThumbnailView.removeFromSuperview()
            }
            ///转发内容区
            self.frame = controller.retweetView
        }
        
    }

}
