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
    var subviewFrame: StatusCellSubviewFrame! {
        didSet {
            setupSubviewsFrames()
        }
    }
    ///昵称+内容
    var retweetMainLabel: UILabel!
    ///转发配图
    var retweetThumbnailView: ThumbnailView!

    convenience init() {
        self.init(frame: CGRectZero)
        self.userInteractionEnabled = true
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
        retweetThumbnailView = ThumbnailView()
        self.addSubview(retweetThumbnailView)
        
    }
    
    /**
     获得微博数据后执行该方法设置转发内容子控件的frame
     */
    func setupSubviewsFrames() {
        if let retweet = subviewFrame.status.retweeted_status {
            ///昵称+内容
            retweetMainLabel.frame = subviewFrame.retweetMainLabel
            if retweet.user != nil {
                let retweetMainText = "@" + retweet.user.name + "：" + retweet.text
                retweetMainLabel.text = retweetMainText
            } else {
                retweetMainLabel.text = retweet.text
            }
            
            if retweet.pic_urls?.count > 0 {

                ///转发配图
                retweetThumbnailView.frame = subviewFrame.retweetThumbnailView
                retweetThumbnailView.subviewFrame = subviewFrame
//                retweetThumbnailView.sd_setImageWithURL(NSURL(string: photo!.thumbnail_pic), placeholderImage: UIImage(named: "timeline_image_placeholder"))
            } else {
                retweetThumbnailView.removeFromSuperview()
            }
            ///转发内容区
            self.frame = subviewFrame.retweetView
        }
        
    }

}
