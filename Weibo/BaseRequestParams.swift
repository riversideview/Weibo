//
//  BaseRequestParams.swift
//  Weibo
//
//  Created by Riversideview on 16/1/4.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class BaseRequestParams: NSObject {
    override init() {
        if let token = AccountTool.localAccount?.access_token {
            access_token = token
        }
    }

    /// access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    var access_token: String!
//        {
//        if let token = AccountTool.localAccount?.access_token {
//            return token
//        }
//        return nil
//    }

}
