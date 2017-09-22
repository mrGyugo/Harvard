//
//  ManagerPersonalData.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 23.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation


class MamagerPersonalData {
    
    class func autorization () {
        
        guard (UserDefaults.standard.value(forKey: Constants.keyAccountSecretKey) != nil) else { return }
        let userDefaults = UserDefaults.standard
        
        //Account------------------------
        let accuntName  = userDefaults.string(forKey: Constants.keyAccountName)!
        let secretKey   = userDefaults.string(forKey: Constants.keyAccountSecretKey)!
        let publickKey  = userDefaults.string(forKey: Constants.keyAccountPublickKey)!

        
        let account = AccountData(accountName: accuntName, accountSeckretKey: secretKey, accountPublicKey: publickKey)
        Singleton.shared.accountData = account
        
        
    }
    
    class func loadAvatar () {
        guard (UserDefaults.standard.value(forKey: Constants.keyAvatarLow) != nil) else { return }
        let avatarLow       = UserDefaults.standard.value(forKey: Constants.keyAvatarLow) as! String
        let avatarMedium    = UserDefaults.standard.value(forKey: Constants.keyAvatarMedium) as! String
        let avatarBig       = UserDefaults.standard.value(forKey: Constants.keyAvatarBig) as! String
        
        let avatar = Avatar(medium: avatarMedium, low: avatarLow, hight: avatarBig)
        Singleton.shared.avatar = avatar
    }
    
    class  func loadSearchParams () {
        
        if UserDefaults.standard.value(forKey: Constants.keyLanguage) != nil {
            let userDefaults = UserDefaults.standard
            let mGender     = userDefaults.value(forKey: Constants.keyMGender)      as! String
            let mAge        = userDefaults.array(forKey: Constants.keyMAgeRange)    as! [Int]
            let hGender     = userDefaults.value(forKey: Constants.keyHGender)      as! String
            let hAge        = userDefaults.value(forKey: Constants.keyHAgeRange)    as! [Int]
            let search      = userDefaults.value(forKey: Constants.keySearchRenge)  as! Int
            let country     = userDefaults.value(forKey: Constants.keyLanguage)     as! String
            
            let languages = OtherMethods.converStringToArrayLanguages(tempString: country)
            
            let mySearchParams = SearchParams(mGender: mGender, mAgeRange: mAge, hGender: hGender, hAgeRange: hAge, searchRange: search, language: languages)
            Singleton.shared.searchParams = mySearchParams
        } else {
            Singleton.shared.searchParams = SearchParams()
        }
        

        
    }
    

}
