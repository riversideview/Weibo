//
//  OAuthViewController.swift
//  Weibo
//
//  Created by Riversideview on 15/12/27.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit
import AFNetworking
@available(iOS, deprecated=1.0, message="I'm not deprecated, please ***FIXME**")
func FIXME()
{
}
class OAuthViewController: UIViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加认证页面
        let webView = UIWebView()
        webView.delegate = self
        webView.frame = CGRect(x: self.view.frame.origin.x, y: 20, width: self.view.frame.width, height: self.view.frame.height - 20)
        webView.scrollView.scrollEnabled = false
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=1547115197&redirect_uri=www.baidu.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        self.view.addSubview(webView)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        FIXME()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL?.absoluteString {
            if let range = url.rangeOfString("http://www.baidu.com/?code=") {
                /// 获取CODE
                let codeRange = Range<String.Index>(start: range.endIndex, end: url.endIndex)
                let code = url.substringWithRange(codeRange)
                accessTokenWithCode(code: code)
                return false
            }
        }
        return true
    }
    
    /*
    lient_id	true	string	申请应用时分配的AppKey。
    client_secret	true	string	申请应用时分配的AppSecret。
    grant_type	true	string	请求的类型，填写authorization_code
    
    grant_type为authorization_code时
    必选	类型及范围	说明
    code	true	string	调用authorize获得的code值。
    redirect_uri	true	string	回调地址，需需
    */
    
    /**
    通过CODE获得TOKEN
    */
    func accessTokenWithCode(code code: String) {
        let manager = AFHTTPSessionManager()
        
        let url = "https://api.weibo.com/oauth2/access_token"
        let params: [String: AnyObject] = [
            
            "client_id": "1547115197",
            "client_secret": "267e5adad587fa29d03a33bf42c54d3b",
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": "http://www.baidu.com",
            
        ]
        /// 由于返回的结构, 必须设置ContentTypes为text/plain！
        let type: Set<String> = ["text/plain"]
        manager.responseSerializer.acceptableContentTypes = type
        
        manager.POST(url, parameters: params, progress: { (progress: NSProgress) -> Void in
            print(progress)
            WeiboTool.chooseViewController()
            }, success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                
                if let account = responseObject as? [String : AnyObject] {
                    //保存从网络获得的账号
                    let currentAccount = Account(account: account)
                    AccountTool.saveAccount(currentAccount)
                    //选择正确的视图控制器
                    WeiboTool.chooseViewController()
                }
            })
            { (_, error: NSError) -> Void in
                print(error)
        }
        
    }
    
}






