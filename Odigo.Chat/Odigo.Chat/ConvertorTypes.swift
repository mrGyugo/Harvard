//
//  ConvertorTypes.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 23.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation

final class ConvertorTypes {
    
    
    class func convertTwoNumbersWithString (numberStart: Int, numberEnd: Int) -> String {
        let string = "\(numberStart)_\(numberEnd)"
        return string
    }
    
    class  func convertNumbersWithString (number: Int) -> String {
        let string = "\(number)"
        return string
    }
    
    class func convertStringToArrayNumbers (string: String) -> [Int]? {
        
        var arrayNumbers: [Int] = []
        let arrayString = string.components(separatedBy: "_")
        for stringNumbers in arrayString {
            if let number = Int(stringNumbers) {
                arrayNumbers.append(number)
            }
        }
        if arrayNumbers.count > 1 {
            return arrayNumbers
        } else {
            return nil
        }
    }
    
    class func convertStringToInt (string: String) -> Int? {
        if let number = Int(string) {
            return number
        } else {
            return nil
        } 
    }
    
    
    class func convertArrayLanguagesToDict (arrayLanguages: [Language]) -> [String] {
        var tempDictArray: [String] = []
        for language in arrayLanguages {
            tempDictArray.append(language.code)
        }
        return tempDictArray
    }

}
