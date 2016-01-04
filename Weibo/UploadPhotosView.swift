//
//  UploadPhotosView.swift
//  Weibo
//
//  Created by Riversideview on 16/1/4.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class UploadPhotosView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var imageTag = 0
    var num = 1
    var photos = [UIImage]() {
        didSet {
            if num == photos.count {
                let imageView = UIImageView()
                imageView.backgroundColor = UIColor.blackColor()
                imageView.tag = imageTag
                imageView.userInteractionEnabled = true
                imageView.image = photos.last
                
                setupDeleteMark(imageView: imageView)
                self.addSubview(imageView)
                layoutSubviews()
                imageTag++
                num++
            } else if num != photos.count  {
                imageTag = 0
                for view in subviews {
                    view.removeFromSuperview()
                }
                for i in 0..<photos.count {
                    
                    let imageView = UIImageView()
                    imageView.tag = imageTag
                    imageView.userInteractionEnabled = true
                    imageView.image = photos[i]
                    setupDeleteMark(imageView: imageView)
                    self.addSubview(imageView)
                    imageTag++
                }
                layoutSubviews()
                num = photos.count
            }
            
        }
        
    }
    func setupDeleteMark(imageView imageView: UIImageView) {
        let mark = UIButton()
        mark.setBackgroundImage(UIImage(named: "compose_delete"), forState: .Normal)
        mark.setBackgroundImage(UIImage(named: "compose_delete"), forState: .Highlighted)
        mark.autoresizingMask = [.FlexibleLeftMargin, .FlexibleBottomMargin]
        mark.frame.size = (mark.currentBackgroundImage?.size)!
        mark.frame.origin = CGPoint(x: imageView.frame.width - mark.frame.width, y: 0)
        mark.addTarget(self, action: "deleteAction:", forControlEvents: .TouchUpInside)
        mark.tag = imageView.tag
        imageView.addSubview(mark)
        print("delete")
    }
    func deleteAction(button: UIButton) {
        print(button)
        photos.removeAtIndex(button.tag)
        
    }

    convenience init() {
        self.init(frame: CGRectZero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let count = photos.count
        
        for i in 0..<count {
            let view = self.subviews[i]
            var f: CGFloat = CGFloat(i)
            let squareWidth = (self.frame.width - imageSpacing * 2) / 3

            var line: CGFloat = 0
            if f >= 6 { //第三行
                if f == 6 {
                    f = 0
                } else if f == 7{
                    f = 1
                } else if f == 8{
                    f = 2
                }
                line = 2
            } else if f >= 3 { //第二行
                if f == 3 {
                    f = 0
                } else if f == 4{
                    f = 1
                } else if f == 5{
                    f = 2
                }
                line = 1
            }
            let y = squareWidth * line + imageSpacing * line
            let x: CGFloat = squareWidth * f + imageSpacing * f
            view.frame = CGRect(x: x, y: y, width: squareWidth, height: squareWidth)
        }
    
    
    }

}
