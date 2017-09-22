//
//  Statistics.swift
//  TestMeteorCollection
//
//  Created by Mac_Work on 15.09.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation


struct Statistic: ProtocolMeteorStruct {
    
    var _id:String?
    var name:String?
    var value:String?
    let collection = "statistics"
    
    
    init (id: String, filds:NSDictionary?) {
        self._id = id
        update(fields: filds)
    }
    
    public var description: String {
        return "name \(name ?? "nil"), value \(value ?? "nil")"
    }

    
    mutating func update(fields: NSDictionary?) {
        
        if let name = fields?.value(forKey: "name") as? String {
            self.name = name
        }
        if let value = fields?.value(forKey: "value") as? String {
            self.value = value
        }
    }
    
}
