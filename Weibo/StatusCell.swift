//
//  StatusCell.swift
//  Weibo
//
//  Created by Riversideview on 15/12/28.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit
///cell内间距
let cellSpacing: CGFloat = 10
///图片间距
let imageSpacing:CGFloat = 5

///昵称字体
let IDFont = UIFont.systemFontOfSize(16)
/// 来源
let SourceFont = UIFont.systemFontOfSize(14)
///发送时间
let TimeFont = UIFont.systemFontOfSize(14)
/// 正文
let MainFont = UIFont.systemFontOfSize(18)
/// 转发正文
let RetweetMainFont = UIFont.systemFontOfSize(17)


class StatusCell: UITableViewCell {
    
    ///内容区
    var statusView: StatusView!
        ///底部评论区
    var commentView: CommentView!

    
    ///自动计算cell的frame并设置frame
    var subviewFrame: StatusCellSubviewFrame! {
        didSet {
            statusView.subviewFrame = subviewFrame
            commentView.subviewFrame = subviewFrame
        }
    }
    
    convenience init() {
        self.init(style: .Default, reuseIdentifier: "StatusCell")

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStatusView()

        setupCommentView()
        
        self.backgroundColor = UIColor.redColor()
        
    }
    
    /**
     初始化内容区
     */
    func setupStatusView() {
        
        ///将内容区添加到contentView
        statusView = StatusView()
        contentView.addSubview(statusView)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

    /**
     初始化评论区
     */
    func setupCommentView() {
        ///底部评论区
        commentView = CommentView()
        contentView.addSubview(commentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
