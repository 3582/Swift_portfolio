//
//  contents.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/09/26.
//  Copyright © 2020 yu_w. All rights reserved.
//

import Foundation

class Contents{
    var userNameString:String = ""
    var titleString:String = ""
    var textString:String = ""
    var createdDateString:String = ""
    
    init(userNameString:String,titleString:String,textString:String,createdDateString:String) {
        self.userNameString = userNameString
        self.titleString = titleString
        self.textString = textString
        self.createdDateString = createdDateString
    }
    
}
