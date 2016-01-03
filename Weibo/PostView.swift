//
//  PostView.swift
//  Weibo
//
//  Created by Riversideview on 16/1/3.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class PostView: UITextView {
    convenience init() {
        self.init(frame: CGRectZero, textContainer: nil)
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: nil)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
