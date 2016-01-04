//
//  PostToolView.swift
//  Weibo
//
//  Created by Riversideview on 16/1/3.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

protocol PostToolDelegate {
    func didClickButton(button: UIButton)
}

enum PostToolButton: Int {
    case PicButton = 0
    case AtButton = 1
    case TopicButton = 2
    case EmotionButton = 3
    case PlusButton = 4
}
class PostToolView: UIView {
    
    var delegate: PostToolDelegate!

    convenience init() {
        self.init(frame: CGRectZero)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "compose_toolbar_background")!)
        setupButtons()
    
    }
    
    
    func setupButtons() {
        setupChildButtonWith("compose_toolbar_picture", highlightImage: "compose_toolbar_picture_highlighted", tag: .PicButton)
        setupChildButtonWith("compose_mentionbutton_background", highlightImage: "compose_mentionbutton_background_highlighted", tag: .AtButton)
       
        setupChildButtonWith("compose_trendbutton_background", highlightImage: "compose_trendbutton_background_highlighted", tag: .TopicButton)
        setupChildButtonWith("compose_emoticonbutton_background", highlightImage: "compose_emoticonbutton_background_highlighted", tag: .EmotionButton)
        setupChildButtonWith("compose_toolbar_more", highlightImage: "compose_toolbar_more_highlighted", tag: .PlusButton)

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupChildButtonWith(image: String, highlightImage: String, tag: PostToolButton) {
        let button = UIButton()
        button.setImage(UIImage(named: image), forState: .Normal)
        button.setImage(UIImage(named: highlightImage), forState: .Highlighted)
        button.addTarget(self, action: "clickButton:", forControlEvents: .TouchUpInside)
        button.tag = tag.rawValue
        
        self.addSubview(button)
        
    }
    func clickButton(button: UIButton) {
        print(button)
        delegate.didClickButton(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var i: CGFloat = 0
        for view in subviews {
            let x: CGFloat = self.frame.width / 5 * i
            let y: CGFloat = 0
            let w: CGFloat = self.frame.width / 5
            let h: CGFloat = self.frame.height
            
            view.frame = CGRect(x: x, y: y, width: w, height: h)
            i++
        }
    }
}
