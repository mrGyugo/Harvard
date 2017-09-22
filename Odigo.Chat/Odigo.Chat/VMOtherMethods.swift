//
//  OtherMethods.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 08.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation
import CoreData


//Доп методы-----------------------------

class OtherMethods {
    
    
    //MARK: - User Defaults
    
    //Метод сохраняет параметры в UserDefaults
    class func setUserDefoltsTutorialWithBlock(keyUsrDefaults: String, action: () -> ()) {
    let userDefaults = UserDefaults.standard
    userDefaults.set(true, forKey: keyUsrDefaults)
    userDefaults.synchronize()
    action()
    }
    
    class func changeName (_ name: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(name,        forKey: Constants.keyAccountName)
        userDefaults.synchronize()
    }

    //Метод сохраняет параметры аккаунта в UserDefaults
    class func setUserDefoltsTutorial(andParams params: Any) {
        guard params is AccountData else { return }
        let tempParams = params as! AccountData
        let userDefaults = UserDefaults.standard
        
        //Account
        userDefaults.set(tempParams.accountName,        forKey: Constants.keyAccountName)
        userDefaults.set(tempParams.accountSeckretKey,  forKey: Constants.keyAccountSecretKey)
        userDefaults.set(tempParams.accountPublicKey,   forKey: Constants.keyAccountPublickKey)
        
        //SearchStruct
        let searchDefault = SearchParams()
        userDefaults.set(searchDefault.mGender,     forKey: Constants.keyMGender)
        userDefaults.set(searchDefault.mAgeRange,   forKey: Constants.keyMAgeRange)
        userDefaults.set(searchDefault.hGender,     forKey: Constants.keyHGender)
        userDefaults.set(searchDefault.hAgeRange,   forKey: Constants.keyHAgeRange)
        userDefaults.set(searchDefault.searchRange, forKey: Constants.keySearchRenge)
        userDefaults.set(OtherMethods.convertToString(languages: searchDefault.language),  forKey: Constants.keyLanguage)
        
        userDefaults.synchronize()

    }
    
    //Метод сохраняет ключи для аватара
    class func setUserDefoltsAvatar(avatar: Avatar) {
        let userDefaults = UserDefaults.standard

        userDefaults.set(avatar.low,        forKey: Constants.keyAvatarLow)
        userDefaults.set(avatar.medium,     forKey: Constants.keyAvatarMedium)
        userDefaults.set(avatar.big,        forKey: Constants.keyAvatarBig)
        
        userDefaults.synchronize()
    }
    
    //Обновить конкретный ключ
    class func updateUserDefaultsWithKey (key: String, andData data: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    //Получить параметры из UserDefaults
    class func getDataInUserDefaultsWithKey (_ key: String) -> Any? {
        let data = UserDefaults.standard.string(forKey: key)
        return data
    }
    
    
    //MARK: - Regular Expressions
    
    //Проверка на подходящее регулярное выражение
    class func checkText(regularExpressions: String, text: String) -> Bool {
        if text.range(of:regularExpressions, options: .regularExpression) != nil {
            return true
        } else {
            return false
        }
    }
    
    //Возвращает значение ключа по значению
    class  func getKeyForIndex (value: Int, andDictionary dictionary: [String: Int]) -> String? {
        let keys = (dictionary as NSDictionary).allKeys(for: value) as! [String]
        if keys.count > 0 {
            return keys[0]
        }
        return nil
    }
    
    //Преобразовать язык в структуру языка
    class func converStringToArrayLanguages (tempString: String) -> [Language] {
        
        var arrayLanguages: [Language] = []
        let languagesString = tempString.components(separatedBy: ":")
        for languageString in languagesString {
            let languagePropertis = languageString.components(separatedBy: "_")
            let language = Language(code: languagePropertis[0], name: languagePropertis[1])
            arrayLanguages.append(language)
        }
        return arrayLanguages
    }
    
    //Преобразовать структуру языка в строку
    class func convertToString (languages: [Language]) -> String {
        var newString = ""
        for (index, language) in languages.enumerated() {
            if index != languages.count - 1 {
                newString = newString + language.code + "_" + language.name + ":"
            } else {
                newString = newString + language.code + "_" + language.name
            }
        }
        return newString
    }
}
