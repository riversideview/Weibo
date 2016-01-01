//
//  Photo.swift
//  Weibo
//
//  Created by Riversideview on 16/1/1.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class Photo: NSObject {
    var thumbnail_pic: String! {
        didSet {

            thumbnail_pic = thumbnail_pic.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
        }
    }
}
