//
//  CustomTabBarButton.swift
//  Weibo
//
//  Created by Riversideview on 15/12/25.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class CustomTabBarButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        item = UITabBarItem()
        super.init(frame: frame)
        
        self.imageView?.contentMode = .Center
        self.titleLabel?.textAlignment = .Center
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.setTitleColor(UIColor.orangeColor(), forState: .Selected)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: UITabBarItem {
        didSet{
            self.item.addObserver(self, forKeyPath: "badgeValue", options: .New, context: nil)
            self.item.addObserver(self, forKeyPath: "title", options: .New, context: nil)
            self.item.addObserver(self, forKeyPath: "image", options: .New, context: nil)
            self.item.addObserver(self, forKeyPath: "selectedImage", options: .New, context: nil)
            observeValueForKeyPath(nil, ofObject: nil, change: nil, context: nil)
        }
    }
    
    deinit {
        self.item.removeObserver(self, forKeyPath: "badgeValue")
        self.item.removeObserver(self, forKeyPath: "title")
        self.item.removeObserver(self, forKeyPath: "image")
        self.item.removeObserver(self, forKeyPath: "selectedImage")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {

        self.setTitle(item.title, forState: .Normal)
        self.setTitle(item.title, forState: .Selected)
        self.setImage(item.image, forState: .Normal)
        self.setImage(item.selectedImage, forState: .Selected)
        
        if item.badgeValue != nil {
            let badgeButton = CustomBadgeButton()
            badgeButton.badge = item.badgeValue
            let badgeX: CGFloat = self.frame.width - badgeButton.frame.width - 10
            let badgeY: CGFloat = 3
            badgeButton.frame.origin = CGPointMake(badgeX, badgeY)
            self.addSubview(badgeButton)
        }
        
    }

    //关闭高亮
    override var highlighted: Bool {
        didSet {
            if highlighted {
                highlighted = false
            }
        }
    }
    
    let imageScale = CGFloat(0.6)

    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let imageX = contentRect.origin.x
        let imageY = contentRect.origin.y
        let imageW = contentRect.width
        let imageH = contentRect.height * imageScale
        return CGRectMake(imageX, imageY, imageW, imageH)
    }
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let titleX = contentRect.origin.x
        let titleY = contentRect.height * imageScale
        let titleW = contentRect.width
        let titleH = contentRect.height - contentRect.height * imageScale
        return CGRectMake(titleX, titleY, titleW, titleH)
    }
    
    

}
