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
    var controller: CellFrameController! {
        didSet {
            statusView.controller = controller
            commentView.controller = controller
        }
    }
    
    //重写父类添加边距
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            let frameX: CGFloat = newValue.origin.x
            let frameY: CGFloat = newValue.origin.y + 5
            let frameW: CGFloat = newValue.width
            let frameH: CGFloat = newValue.height - 5
            let xframe = CGRect(x: frameX, y: frameY, width: frameW, height: frameH)
            super.frame = xframe
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStatusView()

        setupCommentView()
        
        self.backgroundColor = UIColor.clearColor()
        
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
