//
//  LoginUserTool.swift
//  Weibo
//
//  Created by Riversideview on 16/1/5.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class LoginUserTool: NSObject {
    class func SaveLoginUserWith(params: LoginUserRequestParams, success: (LoginUser -> Void), failure: (NSError -> Void)) {
        let url = "https://api.weibo.com/2/users/show.json"
        if let params = params.yy_modelToJSONObject() as? [String: AnyObject] {
            HttpRequestTool.GetRequest(url: url, params: params, success: {
                (data: AnyObject?) -> Void in
                if let user = data as? [String : AnyObject] {
                    //                print(user)
                    let loginUser = LoginUser.yy_modelWithDictionary(user as [NSObject : AnyObject])
                    if let account = AccountTool.localAccount {
                        account.name = loginUser.name
                        AccountTool.SaveAccount(account)
                    }
                    success(loginUser)
                }

                }) { (error: NSError) -> Void in
                    failure(error)
            }
        }
        
    }
}
