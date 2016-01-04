//
//  OAuthTool.swift
//  Weibo
//
//  Created by Riversideview on 16/1/4.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class OAuthTool: NSObject {
    class func GetUserDataWith(params: OAuthRequestParams,type: Set<String>?, success: ([String : AnyObject]? -> Void), failure: (NSError -> Void)) {
        
        let url = "https://api.weibo.com/oauth2/access_token"
        
        if let params = params.yy_modelToJSONObject() as? [String: AnyObject] {
            HttpRequestTool.PostRequest(url: url, params: params, type: type, success: { (data: AnyObject?) -> Void in
                if let account = data as? [String : AnyObject] {
                    //保存从网络获得的账号
                    let currentAccount = Account(account: account)
                    AccountTool.SaveAccount(currentAccount)
                    success(account)
                }
                }) { (error: NSError) -> Void in
                    failure(error)
            }

        }

    }
}
