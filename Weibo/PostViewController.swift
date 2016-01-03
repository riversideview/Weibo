//
//  PostViewController.swift
//  Weibo
//
//  Created by Riversideview on 16/1/3.
//  Copyright © 2016年 Riversideview. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    let textView = PostView()
    ///发送按钮字体
    lazy var postAttributes:[String: AnyObject] = {
        var attributes = [String: AnyObject]()
        attributes[NSShadowAttributeName] = nil
        attributes[NSFontAttributeName] = UIFont.systemFontOfSize(20)
        attributes[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
        return attributes
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupNavBar()

    }
    
    func enableDoneButton() {
        print("enableDoneButton")
        postAttributes[NSForegroundColorAttributeName] = textView.text.characters.count != 0 ? UIColor.orangeColor() : UIColor.lightGrayColor()
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(postAttributes, forState: .Normal)
        navigationItem.rightBarButtonItem?.enabled = textView.text.characters.count != 0
    }
    ///配置navbar
    func setupNavBar() {
        self.navigationItem.title = "发微博"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "cancelAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: "doneAction")
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(postAttributes, forState: .Normal)

        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    ///配置输入文本框
    func setupTextView() {
        textView.frame = self.view.bounds
        self.view.addSubview(textView)
        ///添加文字输入监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enableDoneButton", name: UITextViewTextDidChangeNotification, object: textView)
    }
    func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func doneAction() {
        print("doneAction")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
