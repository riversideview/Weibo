//
//  StatusRequestParams.swift
//  Weibo
//
//  Created by Riversideview on 16/1/4.
//  Copyright © 2016年 Riversideview. All rights reserved.
//  微博请求参数

import UIKit

class StatusRequestParams: BaseRequestParams {
    

    ///since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    var since_id: String!
    /// max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    var max_id: String!
    ///count	false	int	单页返回的记录条数，最大不超过100，默认为20。
    var count: String!
    
    
    
    
    
    
    
}
