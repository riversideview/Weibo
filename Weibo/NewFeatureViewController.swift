//
//  NewFeatureViewController.swift
//  Weibo
//
//  Created by Riversideview on 15/12/26.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class NewFeatureViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupPageControl()
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    let pageControl = UIPageControl()
    func setupPageControl() {
        pageControl.frame.origin = CGPoint(x: self.view.frame.width * 0.5, y: self.view.frame.height * 0.9)
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.view.addSubview(pageControl)
    }
    func setupScrollView() {
        
        let scrollView = UIScrollView(frame: self.view.frame)
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        
        for i in 0..<3 {
            let imageView = UIImageView(image: UIImage(named: "newFeature\(i)"))
            imageView.frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: self.view.frame.height)
            imageView.contentMode = .ScaleToFill
            scrollView.addSubview(imageView)
            scrollView.contentSize = CGSize(width: self.view.frame.width*CGFloat(i+1), height: self.view.frame.height)
            if i == 2 {
                imageView.userInteractionEnabled = true
                let enterButton = UIButton()
                enterButton.setBackgroundImage(UIImage(named: "new_feature_button"), forState: .Normal)
                enterButton.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: .Highlighted)
                enterButton.frame.size = enterButton.currentBackgroundImage!.size
                enterButton.center = CGPoint(x: self.view.frame.width*0.5, y: self.view.frame.height*0.85)
                imageView.addSubview(enterButton)
                enterButton.addTarget(self, action: "enter", forControlEvents: .TouchUpInside)
            }
        }
        self.view.addSubview(scrollView)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let currentPage = (offsetX + self.view.frame.width / 2) / self.view.frame.width
        pageControl.currentPage = Int(currentPage)
    }
    
    func enter() {
        print("enterButton")
        let main = MainTabBarViewController()
        self.view.window?.rootViewController = main
    }
    deinit {
        print("released")
    }
}
