//
//  StaticDictionaries.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 23.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation

//Статические коллекции-----------
//Все возможные выборки-----------

struct StaticDictionaries {
    
    //Выборка пола
    static let dictionaryGender = [
        "" : 0,
        "m": 1,
        "f": 2
    ]
    
    //Выбор возраста для пользователя
    static let dictionaryMyAge = [
        "0_0"   : 0,
        "0_17"  : 1,
        "18_21" : 2,
        "22_25" : 3,
        "25_35" : 4,
        "35_99" : 5
    ]
    
    //Диапозон поиска
    static let dictionarySearch = [
        "0"          : 3,
        "100"        : 0,
        "10000"      : 1,
        "500000"     : 2
    ]

    
    
}
