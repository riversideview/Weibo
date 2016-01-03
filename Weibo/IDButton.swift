//
//  IDButton.swift
//  Weibo
//
//  Created by Riversideview on 15/12/26.
//  Copyright © 2015年 Riversideview. All rights reserved.
//
let IDButtonFont = UIFont.systemFontOfSize(22)
import UIKit

class IDButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        self.adjustsImageWhenHighlighted = false
        self.titleLabel?.font = IDButtonFont
        self.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        self.setBackgroundImage(UIImage.resizeImageWithName(image: "navigationbar_filter_background_highlighted"), forState: .Highlighted)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var clicked = false
    func click() {
        if clicked {
            self.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
            clicked = false
        } else {
            self.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Normal)
            clicked = true
        }
    }
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let imageX: CGFloat = contentRect.width - (self.currentImage?.size.width)!
        let imageY: CGFloat = 0
        let imageW: CGFloat = (self.currentImage?.size.width)!
        let imageH: CGFloat = contentRect.height
        return CGRect(x: imageX, y: imageY, width: imageW, height: imageH)
    }
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let titleX: CGFloat = 0
        let titleY: CGFloat = 0
        let titleW: CGFloat = contentRect.width - (self.currentImage?.size.width)!
        let titleH: CGFloat = contentRect.height
        return CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.backgroundColor = UIColor.clearColor()
        self.imageView?.contentMode = .Center
        self.titleLabel?.textAlignment = .Left

        self.titleLabel?.font = IDButtonFont
        if let title = self.titleLabel?.text {
            if title.characters.count < 12 {
                let titleSize = (title as NSString).sizeWithAttributes([NSFontAttributeName: IDButtonFont as AnyObject])
                let width = titleSize.width
                let hight = titleSize.height
                self.frame.size = CGSize(width: width, height: hight)
            } else {
                let titleSize = (title as NSString).sizeWithAttributes([NSFontAttributeName: IDButtonFont as AnyObject])
                let width = titleSize.width - 50
                let hight = titleSize.height
                self.frame.size = CGSize(width: width, height: hight)
                let x:CGFloat = (UIScreen.mainScreen().bounds.width - self.frame.width) / 2
                let y:CGFloat = (44 - self.frame.height) / 2
                self.frame.origin = CGPoint(x: x, y: y)
            }
            
        }
    }
    

}
