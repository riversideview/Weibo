//
//  OAuthViewController.swift
//  Weibo
//
//  Created by Riversideview on 15/12/27.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

@available(iOS, deprecated=1.0, message="I'm not deprecated, please ***FIXME**")
func FIXME()
{
}
class OAuthViewController: UIViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加认证页面
        setupWebView()
    }
    func setupWebView() {
        let webView = UIWebView()
        webView.delegate = self
        webView.frame = self.view.bounds
        webView.frame.origin.y += 20
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
    
 
    
    /**
    通过CODE获得TOKEN
    */
    func accessTokenWithCode(code code: String) {
        //        let params: [String: AnyObject] = [
//            "client_id": "1547115197",
//            "client_secret": "267e5adad587fa29d03a33bf42c54d3b",
//            "grant_type": "authorization_code",
//            "code": code,
//            "redirect_uri": "http://www.baidu.com",
//        ]
        
        let params = OAuthRequestParams()
        params.client_id = "1547115197"
        params.client_secret = "267e5adad587fa29d03a33bf42c54d3b"
        params.grant_type = "authorization_code"
        params.code = code
        params.redirect_uri = "http://www.baidu.com"
        /// 由于返回的结构, 必须设置ContentTypes为text/plain！
        let type: Set<String> = ["text/plain"]
        
        OAuthTool.GetUserDataWith(params, type: type,
            success: { (account: [String : AnyObject]?) -> Void in
                print(account)            //选择正确的视图控制器
            ShowViewTool.chooseViewController()
            }) { (error: NSError) -> Void in
                print(error)
        }
       
        
        
    }
    
}






