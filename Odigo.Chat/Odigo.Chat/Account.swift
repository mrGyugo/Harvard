//
//  Account.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 22.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation

//Структура хранит в себе параметры акаунта для авторизации и выбора аватара------------
//-----------------------------------------------

struct AccountData {
    
    public var accountName: String
    public private (set) var accountSeckretKey: String
    public private (set) var accountPublicKey: String

    
    mutating func initWithData (accountName: String, accountSeckretKey: String, accountPublicKey: String) {
        self.accountName = accountName
        self.accountSeckretKey = accountSeckretKey
        self.accountPublicKey = accountPublicKey

    }
    
}
