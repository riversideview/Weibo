//
//  CustomTabBar.swift
//  Weibo
//
//  Created by Riversideview on 15/12/24.
//  Copyright © 2015年 Riversideview. All rights reserved.
//


@objc protocol CustomTabBarDelegate {
    optional func didSelectButtonFrom(toint: Int)
}
import UIKit

class CustomTabBar: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let plusButton = UIButton()
    var delegate:CustomTabBarDelegate!

    override init(frame: CGRect) {

        super.init(frame: frame)
        plusButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        plusButton.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        plusButton.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        plusButton.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)

        plusButton.sizeToFit()
        self.addSubview(plusButton)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    func addTabBarButtonWithItem(tabBarItem: UITabBarItem) {
        let button = CustomTabBarButton()
        self.addSubview(button)
        button.item = tabBarItem

        button.addTarget(self, action: "buttonClick:", forControlEvents: .TouchDown)
        if tabBarItem.title == "首页" {
            buttonClick(button)
        }
    }
    
    
    var ssdgadgButton = UIButton()
    
    func buttonClick(button: UIButton) {
        
        delegate.didSelectButtonFrom!(button.tag)
        ssdgadgButton.selected = false
        button.selected = true
        ssdgadgButton = button
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var index: CGFloat = 0
        
        let buttonY: CGFloat = 0
        let buttonWidth: CGFloat = self.frame.width / CGFloat(self.subviews.count)
        let buttonHeight: CGFloat = self.frame.height
        
        plusButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5)
        for button in self.subviews {
            if button != plusButton {
                var buttonX: CGFloat = buttonWidth * index
                if index >= 2 {
                    buttonX += buttonWidth
                }
                let buttonFrame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)
                button.frame = buttonFrame
                button.tag = Int(index)
                index++
            }
        }
        
    }
    
}
