//
//  OAuthRequestParams.swift
//  Weibo
//
//  Created by Riversideview on 16/1/4.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class OAuthRequestParams: NSObject {
    /*
    "client_id": "1547115197",
    "client_secret": "267e5adad587fa29d03a33bf42c54d3b",
    "grant_type": "authorization_code",
    "code": code,
    "redirect_uri": "http://www.baidu.com",

    */
    /*
    client_secret	true	string	申请应用时分配的AppSecret。
    grant_type	true	string	请求的类型，填写authorization_code
    
    grant_type为authorization_code时
    必选	类型及范围	说明
    code	true	string	调用authorize获得的code值。
    redirect_uri	true	string	回调地址，需需
    */
    var client_id: String!
    var client_secret: String!
    var grant_type: String!
    var code: String!
    var redirect_uri: String!
}
