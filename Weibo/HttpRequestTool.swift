//
//  HttpRequestTool.swift
//  Weibo
//
//  Created by Riversideview on 16/1/4.
//  Copyright © 2016年 Riversideview. All rights reserved.
//


import UIKit
import AFNetworking

class HttpRequestTool: NSObject {

    
    class func GetRequest(url url: String, params: [String: AnyObject], success: (AnyObject? -> Void), failure: (NSError -> Void)) {

        let manager = AFHTTPSessionManager()
        manager.GET(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
            success(data)
            }) { (_, error: NSError) -> Void in
                failure(error)
        }
    }
    /**
     发送不带图片的POST请求
     
     - parameter url:     url
     - parameter params:  参数
     - parameter type:    类型
     - parameter success: 成功
     - parameter failure: 失败
     */
    class func PostRequest(url url: String, params: [String: AnyObject], type: Set<String>?, success: (AnyObject? -> Void), failure: (NSError -> Void)) {
        let manager = AFHTTPSessionManager()
        if type != nil {
            manager.responseSerializer.acceptableContentTypes = type
        }
        manager.POST(url, parameters: params, progress: nil, success: { (_, data: AnyObject?) -> Void in
            success(data)
            }) { (_, error: NSError) -> Void in
                failure(error)
        }
    }
    /**
     发送带图片的POST请求
     
     - parameter url:        url
     - parameter params:     参数
     - parameter uploadData: 数据
     - parameter success:    成功
     - parameter failure:    失败
     */
    class func PostRequest(url url: String, params: [String: AnyObject], uploadData: UploadData<String, NSData>?, success: (AnyObject? -> Void), failure: (NSError -> Void)) {
        let manager = AFHTTPSessionManager()
        manager.POST(url, parameters: params, constructingBodyWithBlock: { (data: AFMultipartFormData) -> Void in
            if let theData = uploadData {
                data.appendPartWithFileData(theData.data, name: theData.name, fileName: theData.fileName, mimeType: theData.mimeType)
            }
            }, progress: nil, success: { (_, data: AnyObject?) -> Void in
            success(data)
            }) { (_, error: NSError) -> Void in
                failure(error)
        }
    }
}
public struct UploadData<String, NSData> {
    public var data: NSData!
    public var name: String!
    public var fileName: String!
    public var mimeType: String!
}











