//
//  CommentView.swift
//  Weibo
//
//  Created by Riversideview on 15/12/31.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class CommentView: UIImageView {
    
    /// 转发
    var repostButton: UIButton!
    /// 评论
    var commentsButton: UIButton!
    /// 点赞
    var attitudesButton: UIButton!
    
    ///微博
    var status: Status! {
        didSet {
            setupTextForButtons()
        }
    }
    var controller: CellFrameController! {
        didSet {
            status = controller.status
            self.frame = controller.commentView
        }
    }
    func setupTextForButtons() {
        
        /// 转发
        repostButton.setTitle(status.reposts_count, forState: .Normal)
        /// 评论
        commentsButton.setTitle(status.comments_count, forState: .Normal)
        /// 点赞
        attitudesButton.setTitle(status.attitudes_count, forState: .Normal)

    }
    
    convenience init () {
        self.init(frame:CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.image = UIImage.resizeImageWithName(image: "common_card_bottom_background")
        self.highlightedImage = UIImage.resizeImageWithName(image: "common_card_bottom_background_highlighted")

        repostButton = setupButton("转发", image: "timeline_icon_retweet", backgroundImage: "timeline_card_bottom_background", hightlightBackgroundImage: "timeline_card_bottom_background_highlighted")

        commentsButton = setupButton("评论", image: "timeline_icon_comment", backgroundImage: "timeline_card_bottom_background", hightlightBackgroundImage: "timeline_card_bottom_background_highlighted")

        attitudesButton = setupButton("赞", image: "timeline_icon_unlike", backgroundImage: "timeline_card_bottom_background", hightlightBackgroundImage: "timeline_card_bottom_background_highlighted")

        setupSeparator()
        setupSeparator()
    }
    lazy var separators = [UIImageView]()
    lazy var buttons = [UIButton]()
    func setupSeparator() {
        let separator = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
        
        separators.append(separator)
        self.addSubview(separator)
    }
    
    func setupButton(title: String, image: String, backgroundImage: String, hightlightBackgroundImage: String)  -> UIButton{
        
        let button = UIButton()
        button.setImage(UIImage(named: image), forState: .Normal)
        button.setBackgroundImage(UIImage(named: backgroundImage), forState: .Normal)
        button.setBackgroundImage(UIImage(named: hightlightBackgroundImage), forState: .Highlighted)
        button.adjustsImageWhenHighlighted = false
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(13)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        buttons.append(button)
        self.addSubview(button)
        return button

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        var increment: CGFloat = 0
        for button in buttons {
            
            let buttonX: CGFloat = self.frame.width / 3 * increment
            let buttonY: CGFloat = 0
            let buttonW: CGFloat = self.frame.width / 3
            let buttonH: CGFloat = self.frame.height
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            increment++
        }
        increment = 1
        for separator in separators {
//             |    |    |    |

            let separatorX: CGFloat = self.frame.width / 3 * increment
            let separatorY: CGFloat = 0

            separator.frame.origin = CGPoint(x: separatorX, y: separatorY)
            increment++
        }
    }
    
}
