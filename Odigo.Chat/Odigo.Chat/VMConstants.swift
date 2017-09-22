//
//  Constants.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 04.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation
import UIKit

//Неизменяющиеся параметры-----
//---------------------------

typealias LanguageBlock = ((_ languages: [Language]) -> ())
typealias AvatarBlock = ((_ avatar: UIImage) -> ())


//Alert Closures
typealias AlertBlockCancel          = (() -> ())
typealias AlertBlockConferm         = (() -> ())
typealias AlertBlockSecondConferm   = (() -> ())
typealias AlertBlockThirdConferm    = (() -> ())

struct Constants {
    
    static let userDefaultKeyForTutorial = "VMuserDefauktKeyForTutorial"
    
    //AccountKeys
    static let keyAccountName       = "VMkeyAccountName"
    static let keyAccountSecretKey  = "VMkeyAccountSecretKey"
    static let keyAccountPublickKey = "VMkeyAccountPublickKey"

    
    //SearchParamsKey
    static let keyMGender           = "VMkeyMGender "
    static let keyMAgeRange         = "VMkeyMAgeRange"
    static let keyHGender           = "VMkeyHGender"
    static let keyHAgeRange         = "VMkeyHAgeRange"
    static let keySearchRenge       = "VMkeySearchRenge"
    static let keyLanguage          = "VMkeyLanguage"
    
    
    //Avatar
    static let keyAvatarLow             = "VMkeyAvatarLow"
    static let keyAvatarMedium          = "VMkeyAvatarMedium"
    static let keyAvatarBig             = "VMkeyAvatarBig"
    
}

//Константы шрифтов и Цветов (hex)

//MARK: - FONTS

struct VMFonts {
    static let fontLight        = "SFUIText-Light"
    static let fontMedium       = "SFUIText-Medium"
    static let fontRegular      = "SFUIText-Regular"
    static let SegoeScriptBold  = "SegoeScript-Bold"
    static let SegoeScript      = "SegoeScript"
}

//MARK: - COLORS

struct VMColors {
    static let darkBlue         = "394B58"
    static let white            = "FFFFFF"
    static let darkGrey         = "627482"
    static let grey             = "C1C1C1"
    static let liteBlue         = "C7D3DD"
    static let yellow           = "CFAB00"
    static let greyBlue         = "7B8C99"
    static let blue             = "37457A"
}


//Все регулярные выражения

struct VMRegularExpressions {
    static let textLogin        = "^[a-zA-Z]([_.-]?[a-zA-Z0-9]){4,20}$"
}


//Key for subscribe-----------

//Statistics
struct KeyStutistics {
    static let onlineUsers              = "online_users_count"
    static let searchUsers              = "pickups_count"
    static let onlineSearchUsers        = "online_pickups_count"
    static let users                    = "users_count"
}


