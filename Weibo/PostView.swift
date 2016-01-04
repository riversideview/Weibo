//
//  PostView.swift
//  Weibo
//
//  Created by Riversideview on 16/1/3.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit
let PostFont = UIFont.systemFontOfSize(20)

class PostView: UITextView, UITextViewDelegate {
    
    lazy var placeholder:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGrayColor()
        label.frame.origin = CGPoint(x: 5, y: 7)
        label.numberOfLines = 0
        return label
    }()
    
    var placeholderText: String! {
        didSet {
            placeholder.text = placeholderText
            placeholder.font = PostFont
            placeholder.sizeToFit()
//            let text = NSAttributedString(string: placeholderText, attributes: [NSFontAttributeName: PostFont as AnyObject])
//            let size = text.boundingRectWithSize(CGSize(width: UIScreen.mainScreen().bounds.width - 6, height: CGFloat.max), options: .UsesLineFragmentOrigin, context: nil).size
//            
//            placeholder.frame.size = size
        }
    }
    
    
    convenience init() {
        self.init(frame: CGRectZero, textContainer: nil)
        placeholder.backgroundColor = UIColor.clearColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shouldShowPlaceholder", name: UITextViewTextDidChangeNotification, object: self)
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: nil)
    }
    deinit {
        print("textview is nil")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholder.font = font
        self.addSubview(placeholder)
        
    }
    func shouldShowPlaceholder() {
        placeholder.hidden = self.text.characters.count != 0
    }
    
    
}
