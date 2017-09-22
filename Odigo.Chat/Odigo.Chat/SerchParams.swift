//
//  SerchParams.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 23.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation

//Структура хранит в себе параметры пользоватлеьской выборки при поиске пользователя
//По умолчания выбраются параметры не важно----------------
//---------------------

struct SearchParams {
    
    var mGender: String = ""
    var mAgeRange: [Int] = [0,  0]
    var hGender: String = ""
    var hAgeRange: [Int] = [0, 0]
    var searchRange: Int = 0
    var language: [Language] = [Language.init(code: "ru", name: "Русский")]
    
    mutating func initWithMyParamth(mGender: String, mAgeRange: [Int], hGender: String, hAgeRange: [Int], searchRange: Int, language: [Language]) {
        self.mGender = mGender
        self.mAgeRange = mAgeRange
        self.hGender = hGender
        self.hAgeRange = hAgeRange
        self.searchRange = searchRange
        self.language = language
    }
    
    //MARK: - Public Func
    
    

}

extension Language : Equatable {}

func == (lhs: Language, rhs: Language) -> Bool {
    return lhs.code == rhs.code
}

struct Language {
    var code: String
    var name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
