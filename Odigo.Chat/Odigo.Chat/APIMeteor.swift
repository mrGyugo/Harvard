//
//  APIMeteor.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 21.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation
import SwiftDDP
import SwiftyJSON

class APIMeteor {
    
    //Registaration
    
    class func registrationWithName(name: String, callBack: @escaping (_ result:Any?, _ error:DDPError?) -> ()) {
        
        let tuplPassword = GenerationPassword.createPassword()
        
        Meteor.signupWithUsername(name, password: tuplPassword.secretKeyString!,
                                  email: nil, profile: ["publicKey" : tuplPassword.publicKeyString!])
        { (response, error) in
            if response != nil {
                let account = AccountData(accountName: name, accountSeckretKey: tuplPassword.secretKeyString!, accountPublicKey: tuplPassword.publicKeyString!)
                OtherMethods.setUserDefoltsTutorial(andParams: account)
                MamagerPersonalData.autorization()
            }
            callBack(response, error) }
    }
    
    //Name
    
    class func changeName(name: String, callBack: @escaping (_ result:Any?, _ error:DDPError?) -> ()) {
        Meteor.call("users.editLogin", params: [["newUsername" : name]], callback: callBack)
    }
    
    class func checkName (name: String, callBack: @escaping (_ result:Any?, _ error:DDPError?) -> ()) {
        Meteor.call("users.loginExistCheck", params: [["username" : name]], callback: callBack)
    }

    
    
    
    //Languages
    
    class func getLanguages(callBack: @escaping ([Language]) -> ()) {
        
        Meteor.call("pickup_settings.get", params: [], callback: { (result, error) in
            guard error == nil else { return }
            let json = JSON(result!)
            
            
            print(json)
            
            let arrayName =  json["languages"].arrayValue.map({$0["name"].stringValue})
            let arrayCode =  json["languages"].arrayValue.map({$0["code"].stringValue})
            var arrayLanguages: [Language] = []
            for (index, _) in arrayName.enumerated() {
                let language = Language(code: arrayCode[index], name: arrayName[index])
                arrayLanguages.append(language)
            }
            callBack(arrayLanguages)
        })
    }
    
    //Avatars
    
    class func getAvatars(callBack: @escaping (_ avatarsArray: [Avatar]) -> ()) {
        Meteor.call("avatars.get", params: [], callback: { (result, error) in
            guard error == nil else { return }
            
           
            
            let json = JSON(result!)
            
            var avatarsArray: [Avatar] = []
            
            for (_, subJson) in json {
                let postfixMedium = subJson["postfixMedium"].stringValue
                let format = subJson["format"].stringValue
                let postfixLow = subJson["postfixLow"].stringValue
                let nameImage = subJson["name"].stringValue
                let postfixHigh = subJson["postfixHigh"].stringValue
                let url = subJson["url"].stringValue
                
                let imageLow = url + nameImage + postfixLow + format
                let imageMedium = url + nameImage + postfixMedium + format
                let imageHigh = url + nameImage + postfixHigh + format
                
                let avatar = Avatar(medium: imageMedium, low: imageLow, hight: imageHigh)
                avatarsArray.append(avatar)

            }

            
            
            callBack(avatarsArray)
            
            
        })
    }
    

}
