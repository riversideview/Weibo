//
//  PostTool.swift
//  Weibo
//
//  Created by Riversideview on 16/1/4.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class PostTool: NSObject {
    /**
     发送不带图片的微博
     */
    class func PostTextWith(params: PostRequestParams, success: (AnyObject? -> Void), failure: (NSError -> Void)) {
        let url = "https://api.weibo.com/2/statuses/update.json"
        if let params = params.yy_modelToJSONObject() as? [String: AnyObject] {
            HttpRequestTool.PostRequest(url: url, params: params, type: nil, success: { (data: AnyObject?) -> Void in
                    success(data)
                }, failure: { (error: NSError) -> Void in
                    failure(error)
            })
        }
    }
    /**
     发送带图片的微博
     */
    class func PostTextAndPhotoWith(params: PostRequestParams, uploadData: UploadData<String, NSData>, success: (AnyObject? -> Void), failure: (NSError -> Void)) {
        let url = "https://upload.api.weibo.com/2/statuses/upload.json"
        if let params = params.yy_modelToJSONObject() as? [String: AnyObject] {
            HttpRequestTool.PostRequest(url: url, params: params, uploadData: uploadData, success: { (data: AnyObject?) -> Void in
                    success(data)
                }) { (error: NSError) -> Void in
                    failure(error)
            }
        }
    }

}
