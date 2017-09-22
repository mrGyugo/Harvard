//
//  Pickups.swift
//  TestMeteorCollection
//
//  Created by Mac_Work on 21.09.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation


struct Pickups: ProtocolMeteorStruct {
    
    var _id:String?
    var userId:String?
    let collection = "pickups"
    
    init (id: String, filds:NSDictionary?) {
        self._id = id
        update(fields: filds)
    }
    
    public var description: String {
        return "name \(userId ?? "nil")"
    }
    
    mutating func update(fields: NSDictionary?) {
        if let userID = fields?.value(forKey: "userId") as? String {
            self.userId = userID
        }
    }
    
}
