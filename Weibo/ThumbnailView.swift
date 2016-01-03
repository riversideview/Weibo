//
//  ThumbnailView.swift
//  Weibo
//
//  Created by Riversideview on 16/1/1.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class ThumbnailView: UIView {

    var photos: [Photo]! {
        didSet {
            for i in 0..<photos.count {
                let photo = photos[i]
                let imageView = UIImageView()
                //            http://ww4.sinaimg.cn/thumbnail/82383abfjw1ezjx6mp94wj20qo0zk485.jpg
                var imageURL = photo.thumbnail_pic.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
                if imageURL.rangeOfString(".gif") != nil {
                    imageURL = imageURL.stringByReplacingOccurrencesOfString("bmiddle", withString: "thumbnail")
                    setupGifMark(imageView: imageView)
                }
                
                imageView.tag = i
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "clickImage:"))

                imageView.sd_setImageWithURL(NSURL(string: imageURL), placeholderImage: UIImage(named: "timeline_image_placeholder"))
                imageView.contentMode = .ScaleAspectFill
                imageView.clipsToBounds = true
                self.addSubview(imageView)
                
            }
            setupSubviewsFrames(photos.count)
        }
    }
    
    func setupGifMark(imageView imageView: UIImageView) {
        let gifMark = UIImageView(image: UIImage(named: "timeline_image_gif"))
        gifMark.autoresizingMask = [.FlexibleLeftMargin, .FlexibleTopMargin]
        gifMark.frame.origin = CGPoint(x: imageView.frame.width - gifMark.frame.width, y: imageView.frame.height - gifMark.frame.height)
        imageView.addSubview(gifMark)
        print("gif")
    }

    func clickImage(gesture: UIGestureRecognizer) {
        print(gesture.view!.tag)
    }
    var subviewFrame: StatusCellSubviewFrame! {
        didSet {
            
            if subviewFrame.status.pic_urls?.count > 0 {
                photos = subviewFrame.status.pic_urls as! [Photo]
            } else if subviewFrame.status.retweeted_status?.pic_urls?.count > 0 {
                photos = subviewFrame.status.retweeted_status?.pic_urls as! [Photo]
            }
        }
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        self.backgroundColor = UIColor.clearColor()
        self.userInteractionEnabled = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
    }
//    func addWaterMake(view: UIView) {
//        if view.tag == 2{
//            let gifMark = UIImageView(image: UIImage(named: "timeline_image_gif"))
//            
//            gifMark.frame.origin = CGPoint(x: view.frame.width - gifMark.frame.width, y: view.frame.height - gifMark.frame.height)
//            view.addSubview(gifMark)
//            print("gif image")
//        }
//
//    }
//    
    func setupSubviewsFrames(imageCount: Int) {
        
        if imageCount == 1 { //单张图片
            for i in 0..<imageCount {
                let view = self.subviews[i]
                let x: CGFloat = 0
                let y: CGFloat = 0
                let w: CGFloat = self.frame.width / 2.5
                let h: CGFloat = self.frame.height
                view.frame = CGRect(x: x, y: y, width: w, height: h)
            }
        } else if imageCount == 2 { //两张图片
            
            for i in 0..<imageCount {
                let view = self.subviews[i]
                let f: CGFloat = CGFloat(i)
                
                let x: CGFloat = (self.frame.width / 2.5) * f + imageSpacing * f
                let y: CGFloat = 0 //单行为零
                let w: CGFloat = self.frame.width / 2.5
                let h: CGFloat = self.frame.height
                
                view.frame = CGRect(x: x, y: y, width: w, height: h)

            }
        } else if imageCount == 4 {
            for i in 0..<imageCount {
                let view = self.subviews[i]
                var f: CGFloat = CGFloat(i)
                
                let squareWidth = (self.frame.width - imageSpacing * 2) / 2.8
                
                var line: CGFloat = 0
                if f >= 2 {
                    if f == 2 {
                        f = 0
                    } else {
                        f = 1
                    }
                    line = 1
                }
                let y = squareWidth * line + imageSpacing * line
                let x: CGFloat = squareWidth * f + imageSpacing * f
                
                view.frame = CGRect(x: x, y: y, width: squareWidth, height: squareWidth)

            }
        } else if imageCount == 3 {
            for i in 0..<imageCount {
                let view = self.subviews[i]
                let f: CGFloat = CGFloat(i)
                
                let squareWidth = (self.frame.width - imageSpacing * 2) / 3
                
                let line: CGFloat = 0
                
                let y = squareWidth * line + imageSpacing * line
                let x: CGFloat = squareWidth * f + imageSpacing * f
                
                view.frame = CGRect(x: x, y: y, width: squareWidth, height: squareWidth)
            }
        } else if imageCount > 4 {
            
            
            for i in 0..<imageCount {
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
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
