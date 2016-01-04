//
//  TimeLine.swift
//  Weibo
//
//  Created by Riversideview on 16/1/5.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit
import YYModel
class TimeLine: NSObject, YYModel {
    var total_number: String!
    //微博内容
    var statuses: NSArray?
    
    static func modelContainerPropertyGenericClass() -> [NSObject : AnyObject]! {
        return ["statuses": Status.self]
    }

}
