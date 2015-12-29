//
//  CustomBadgeButton.swift
//  Weibo
//
//  Created by Riversideview on 15/12/25.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class CustomBadgeButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var badge: String? {
        didSet {
            self.setTitle(badge, forState: .Normal)
            if (badge! as NSString).length > 2 {
                let badgeSize = (badge! as NSString).sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(9) as AnyObject])
                let badgeW = badgeSize.width + 10
                let badgeH: CGFloat! = self.currentBackgroundImage?.size.height
                self.frame.size = CGSize(width: badgeW, height: badgeH)
            } else {
                let badgeW: CGFloat! = self.currentBackgroundImage?.size.width
                let badgeH: CGFloat! = self.currentBackgroundImage?.size.height
                self.frame.size = CGSize(width: badgeW, height: badgeH)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.FlexibleLeftMargin, .FlexibleBottomMargin]
        self.userInteractionEnabled = false
        self.titleLabel?.font = UIFont.systemFontOfSize(11)
        self.setBackgroundImage(UIImage.resizeImageWithName(image: "main_badge"), forState: .Normal)

    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
