//
//  GenerationPassword.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 21.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation
import Sodium


class GenerationPassword {
    
    class func createPassword() -> (secretKeyString: String?, publicKeyString: String?) {
        
        let sodium = Sodium()!
        let keySodium = sodium.box.keyPair()
        let secretKey = keySodium?.secretKey
        let publicKey = keySodium?.publicKey
        let secretKeyString = secretKey?.base64EncodedString()
        let publicKeyString = publicKey?.base64EncodedString()
        
        guard secretKeyString != nil else { return (nil, nil) }
        guard publicKeyString != nil else { return (nil, nil) }
        
        return (secretKeyString, publicKeyString)
    }
}
