//
//  StatusTool.swift
//  Weibo
//
//  Created by Riversideview on 16/1/4.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit
import YYModel
class StatusTool: NSObject {
    
    class func ShowHomeStatusWith(params: StatusRequestParams, success: (AnyObject? -> Void), failure: (NSError -> Void)) {
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        if let params = params.yy_modelToJSONObject() as? [String: AnyObject] {
            HttpRequestTool.GetRequest(url: url, params: params, success: { (data: AnyObject?) -> Void in
                success(data)
                }) { (error: NSError) -> Void in
                    print("failed \(error)")
            }
        }
    }
}
