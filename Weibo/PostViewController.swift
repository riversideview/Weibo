//
//  PostViewController.swift
//  Weibo
//
//  Created by Riversideview on 16/1/3.
//  Copyright © 2016年 Riversideview. All rights reserved.
//
import UIKit
import AFNetworking


class PostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        setupPostToolView()
    }
    
    func enablePostButton() {

        postAttributes[NSForegroundColorAttributeName] = textView.text.characters.count != 0 ? UIColor.orangeColor() : UIColor.lightGrayColor()
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(postAttributes, forState: .Normal)
        navigationItem.rightBarButtonItem?.enabled = textView.text.characters.count != 0
    }
    ///配置navbar
    func setupNavBar() {
        self.navigationItem.title = "发微博"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "cancelAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: "sendAction")
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(postAttributes, forState: .Normal)

        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        textView.becomeFirstResponder()
    }
    
    
    
    ///配置输入文本框
    func setupTextView() {
        textView.alwaysBounceVertical = true
        textView.font = PostFont
        textView.delegate = self
        textView.frame = self.view.bounds
        textView.placeholderText = "分享新鲜事..."

        self.view.addSubview(textView)
        ///添加文字输入监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enablePostButton", name: UITextViewTextDidChangeNotification, object: textView)
    }
    func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func sendAction() {
        
        let manager = AFHTTPSessionManager()
        var params: [String: AnyObject]!
        let url = "https://api.weibo.com/2/statuses/update.json"
        if let token = AccountTool.localAccount?.access_token {
             params = [
                "status": textView.text,
                "access_token": token
            ]
        }
        
        manager.POST(url, parameters: params, progress: nil, success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                print("已发送")

            })
            { (_, error: NSError) -> Void in
                print(error)
        }

        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
    
    let postToolView = PostToolView()

    func setupPostToolView() {
        postToolView.delegate = self
        postToolView.frame.origin = CGPoint(x: 0, y: self.view.bounds.height - 44 - 64)
        postToolView.frame.size = CGSize(width: self.view.frame.width, height: 44)
        self.view.addSubview(postToolView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showPostToolView:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hiddenPostToolView:", name: UIKeyboardDidHideNotification, object: nil)
    }
    func showPostToolView(notification: NSNotification) {

        let duration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! NSTimeInterval
        let rect = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(duration) { () -> Void in
            self.postToolView.transform = CGAffineTransformMakeTranslation(0, -rect.height)
            
        }
    }
    func hiddenPostToolView(notification: NSNotification) {
        print("")
        print("")
        print("")
        let duration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! NSTimeInterval

        UIView.animateWithDuration(duration) { () -> Void in
            self.postToolView.transform = CGAffineTransformIdentity
        }
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    lazy var imagePicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        return picker
    }()
    let niconico = UIImageView()

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("imagePickerController")
        niconico.frame.size = CGSize(width: 60, height: 66)
        niconico.center = self.view.center
        print(image)
        niconico.image = image
        print(niconico)

        self.view.addSubview(niconico)
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }

    
}

extension PostViewController: PostToolDelegate {

    func didClickButton(button: UIButton) {
        switch button.tag {
        case PostToolButton.AtButton.rawValue:
            print("AtButton")
        case PostToolButton.EmotionButton.rawValue:
            print("EmotionButton")

        case PostToolButton.PicButton.rawValue:
            print("PicButton")

            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        case PostToolButton.PlusButton.rawValue:
            print("PlusButton")

        case PostToolButton.TopicButton.rawValue:
            print("TopicButton")

        default:break
        }
    }
}
