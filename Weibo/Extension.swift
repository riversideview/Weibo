//
//  Extension.swift
//  Weibo
//
//  Created by Riversideview on 15/12/26.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import Foundation
import UIKit
extension UIBarButtonItem {
    class func addIconWithItem(image image: String, highlight: String, target: AnyObject, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .Custom)
        button.imageView?.contentMode = .Center
        button.setBackgroundImage(UIImage(named: image), forState: .Normal)
        button.setBackgroundImage(UIImage(named: highlight), forState: .Highlighted)
        button.frame.size = button.currentBackgroundImage!.size
        button.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}

extension UIImage {
    
    class func resizeImageWithName(image image: String) -> UIImage? {
        let image = UIImage(named: image)
        let w = Int((image?.size.width)! / 2)
        let h = Int((image?.size.height)! / 2)
        return image?.stretchableImageWithLeftCapWidth(w, topCapHeight: h)
    }
    
}
