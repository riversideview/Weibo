//
//  ISearchBar.swift
//  Weibo
//
//  Created by Riversideview on 15/12/26.
//  Copyright © 2015年 Riversideview. All rights reserved.
//

import UIKit

class ISearchBar: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.background = UIImage.resizeImageWithName(image: "search_navigationbar_textfield_background")
        self.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width-50, height: 34)
        let searchIcon = UIImageView(image: UIImage(named: "searchbar_textfield_search_icon"))
        
        self.leftView = searchIcon
        self.leftViewMode = .UnlessEditing
        self.placeholder = "搜索"
        self.clearButtonMode = .WhileEditing
        self.returnKeyType = .Search
        self.enablesReturnKeyAutomatically = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.leftView?.contentMode = .Center
        self.leftView?.frame.size = CGSize(width: 30, height: 30)
    }
   
    
    

}
