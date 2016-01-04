//
//  PostViewController.swift
//  Weibo
//
//  Created by Riversideview on 16/1/3.
//  Copyright © 2016年 Riversideview. All rights reserved.
//
import UIKit

class PostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let textView = PostView()
    let postToolView = PostToolView()
    let uploadPhotosView = UploadPhotosView()

    
    
    ///图片选择控制器
    lazy var imagePicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        return picker
    }()


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
        setupUploadPhotosView()
    }
    
    
    func enablePostButton() {

        postAttributes[NSForegroundColorAttributeName] = textView.text.characters.count != 0 ? UIColor.orangeColor() : UIColor.lightGrayColor()
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(postAttributes, forState: .Normal)
        navigationItem.rightBarButtonItem?.enabled = textView.text.characters.count != 0
    }
    ///配置上传图片view
    func setupUploadPhotosView() {
        let y: CGFloat = 90
        let w: CGFloat = self.view.frame.width - cellSpacing*2
        let h: CGFloat = self.view.frame.height
        let x: CGFloat = (self.view.frame.width - w) / 2
        uploadPhotosView.frame = CGRect(x: x, y: y, width: w, height: h)
        self.view.insertSubview(uploadPhotosView, belowSubview: self.postToolView)
    }
    ///配置navbar
    func setupNavBar() {
        self.navigationItem.title = "发微博"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "cancelAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: "sendAction")
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(postAttributes, forState: .Normal)
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        ///添加点击取消编辑
        self.navigationController?.navigationBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "resignTextView"))
    }
    func resignTextView() {
        textView.resignFirstResponder()
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
    ///发送按钮
    func sendAction() {
        if uploadPhotosView.photos.count == 0 {
            sendStatusWithoutPhoto()
        } else {
            sendStatusWithPhotos()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    ///滑动界面停止编辑
    func scrollViewDidScroll(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
    

    func setupPostToolView() {
        postToolView.delegate = self//代理点击按钮
        postToolView.frame.origin = CGPoint(x: 0, y: self.view.bounds.height - 108)//108是导航栏高度+statusbar高度
        postToolView.frame.size = CGSize(width: self.view.frame.width, height: 44)
        self.view.addSubview(postToolView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showPostToolView:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hiddenPostToolView:", name: UIKeyboardDidHideNotification, object: nil)
    }
    ///发送微博不带图片
    func sendStatusWithoutPhoto() {

        let params = PostRequestParams()
        params.status = textView.text
        
        PostTool.PostTextWith(params, success: { (_) -> Void in
            print("已发送")
            }) { (error: NSError) -> Void in
                print(error)
        }
        
    }
    ///发送微博带图片
    func sendStatusWithPhotos() {

        let params = PostRequestParams()
        params.status = textView.text
        
        var uploadData = UploadData<String, NSData>()
        if let photo = uploadPhotosView.photos.last {
            uploadData.name = "pic"
            uploadData.data = UIImageJPEGRepresentation(photo, 0.8)
            uploadData.fileName = "x.jpg"
            uploadData.mimeType = "image/jpeg"
        }
        PostTool.PostTextAndPhotoWith(params, uploadData: uploadData, success: { (_) -> Void in
            print("发送成功")
            }) { (error: NSError) -> Void in
                print(error)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    ///图片选择器代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        print("imagePickerController")
        uploadPhotosView.photos.append(image)
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    ///键盘弹出工具栏也弹出
    func showPostToolView(notification: NSNotification) {
        if let duration = notification.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? NSTimeInterval {
            if let rect = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as? NSValue) {
                UIView.animateWithDuration(duration) { () -> Void in
                    self.postToolView.transform = CGAffineTransformMakeTranslation(0, -rect.CGRectValue().height)
                }
            }
        }
    }
    ///键盘回弹工具栏归位
    func hiddenPostToolView(notification: NSNotification) {
        if let duration = notification.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? NSTimeInterval {
            UIView.animateWithDuration(duration) { () -> Void in
                self.postToolView.transform = CGAffineTransformIdentity
            }
        }
    }
}

extension PostViewController: PostToolDelegate {
    ///按钮响应代理方法
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
