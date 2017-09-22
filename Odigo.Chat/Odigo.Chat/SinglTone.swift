//
//  SinglTone.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 23.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation

// MARK: - Singleton

final class Singleton {
    
    private init() { }
    
    static let shared = Singleton()
    var accountData: AccountData?
    var searchParams: SearchParams?
    var avatar: Avatar?
    
}
