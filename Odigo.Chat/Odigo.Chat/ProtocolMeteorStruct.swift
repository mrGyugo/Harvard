//
//  File.swift
//  TestMeteorCollection
//
//  Created by Mac_Work on 21.09.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation


protocol ProtocolMeteorStruct: CustomStringConvertible {
    
    var _id:String?     { get set }
    var collection: String { get }

    
    init (id: String, filds:NSDictionary?)
    mutating func update(fields: NSDictionary?)
    
    
    
    
    
}
