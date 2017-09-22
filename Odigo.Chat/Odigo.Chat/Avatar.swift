//
//  Avatar.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 15.07.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation

struct Avatar {
    
    var medium: String?     = nil
    var low: String?        = nil
    var big: String?      = nil
    
    init(medium: String, low: String, hight: String) {
        self.medium = medium
        self.low = low
        self.big = hight
    }

}
