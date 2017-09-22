
//
//  UserCollection.swift
//  TestMeteorCollection
//
//  Created by Mac_Work on 15.09.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation
import SwiftDDP


protocol UpdateCollectionProtocol {
    func dataStatisticsApdate (arrayStatistics: [ProtocolMeteorStruct], type: String)
}


class UserCollection <T: ProtocolMeteorStruct>: AbstractCollection {
    
    var collectionName: String!
    
    public init(name: String, collectionName: String) {
        self.collectionName = collectionName
        super.init(name: name)
    }
    var delegate: UpdateCollectionProtocol?
    
    var arrayObjects = [T]() {
        didSet {
            if delegate != nil {
                delegate?.dataStatisticsApdate(arrayStatistics: arrayObjects, type: collectionName)
            }
        }
    }
    
    // Include any logic that needs to occur when a document is added to the collection on the server
    override public func documentWasAdded(_ collection:String, id:String, fields:NSDictionary?) {
        let object = T(id: id, filds: fields)
        arrayObjects.append(object)
    }
    
    
    // Include any logic that needs to occur when a document is changed on the server
    override public func documentWasChanged(_ collection:String, id:String, fields:NSDictionary?, cleared:[String]?) {
        if let index = arrayObjects.index(where: { statistic in return statistic._id == id }) {
            var object = arrayObjects[index]
            object.update(fields: fields)
            arrayObjects[index] = object
        }
    }
    
    // Include any logic that needs to occur when a document is removed on the server
    override public func documentWasRemoved(_ collection:String, id:String) {
        if let index = arrayObjects.index(where: { statistic in return statistic._id == id }) {
            
            print(collection)
            
            arrayObjects.remove(at: index)
            
            
            
            
        }
    }

    
}
