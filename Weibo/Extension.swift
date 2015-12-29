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
        button.setBackgroundImage(UIImage(named: image), forState: .Normal)
        button.setBackgroundImage(UIImage(named: highlight), forState: .Highlighted)
        //        leftButton.frame.size = leftButton.currentBackgroundImage!.size
        button.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        button.sizeToFit()
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}