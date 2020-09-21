//
//  contents.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/09/21.
//  Copyright © 2020 yu_w. All rights reserved.
//

import Foundation

class Contents{
    var userNameString:String = ""
    var userImageString:String = ""
    var contentImageString:String = ""
    var titleString:String = ""
    var commentString:String = ""
    var postDateString:String = ""
    
    init(userNameString:String,userImageString:String,contentImageString:String,titleString:String,commentString:String,postDateString:String) {
        self.userNameString = userNameString
        self.userImageString = userImageString
        self.contentImageString = contentImageString
        self.titleString = titleString
        self.commentString = commentString
        self.postDateString = postDateString
    }
    
}
