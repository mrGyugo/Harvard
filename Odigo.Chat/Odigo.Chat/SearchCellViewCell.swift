//
//  SearchCellViewCell.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 13.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

protocol SearchCellViewCellDelegate {
    func didPressCellGender(cell:SearchCellViewCell)
    func didPressCellAge(cell:SearchCellViewCell)
}

class SearchCellViewCell: UITableViewCell {
    
    @IBOutlet private weak var fonImage: UIImageView!
    @IBOutlet private weak var labelGender: UILabel!
    @IBOutlet private weak var labelAge: UILabel!
    @IBOutlet private var arrayGenderButtons: [UIButton]!
    @IBOutlet private var arrayAgeButtons: [UIButton]!
    private var arrayButtonsHumanActiv: [Int] = []
    
    var delegate:SearchCellViewCellDelegate?
    public var mySearch: Bool = true {
        didSet {
            if !mySearch {
                guard Singleton.shared.searchParams != nil else {
                    self.blockButtonsGender()
                    self.blockButtonsAge()
                    return }
                if Singleton.shared.searchParams?.mGender == "" {
                    self.blockButtonsGender()
                }
                if (Singleton.shared.searchParams?.mAgeRange)! == [0,  0] {
                    self.blockButtonsAge()
                }
            }
        }
    }
    
    //MARK: - Publick Func
    
    public func checkParamsGender (searchParams: String, strunctDict dict: [String : Int]) {
        guard let nedeedIndexMyGender = dict[searchParams] else { return }
        self.serchButtonWithArray(self.arrayGenderButtons, andFindIndex: nedeedIndexMyGender)
    }
    
    public func checkParamsAge (searchParams: String, strunctDict dict: [String : Int]) {
        guard let nedeedIndexMyGender = dict[searchParams] else { return }
        self.serchButtonWithArray(self.arrayAgeButtons, andFindIndex: nedeedIndexMyGender)
    }
    
    public func checkParamsHumanAge (searchParams: String, strunctDict dict: [String : Int]) {
        if searchParams == "0_0" {
            self.serchButtonWithArray(self.arrayAgeButtons, andFindIndex: 0)
        } else if let nedeedIndexMyGender = dict[searchParams] {
            self.arrayButtonsHumanActiv.append(nedeedIndexMyGender)
            self.serchButtonWithArray(self.arrayAgeButtons, andFindIndex: nedeedIndexMyGender)
        } else {
            self.checkWithAutorizationManyItems(searchParam: searchParams)
        }
    }
    
    public func updateWithPerson (_ person: Bool) {
        if person {
            fonImage.alpha = 0
        } else {
            labelGender.text = "ПОЛ СОБЕСЕДНИКА"
            labelAge.text = "ВОЗРАСТ СОБЕСЕДНИКА"
        }
    }
    
    public func blockButtonsGender () {
        checkButtonOnColor(button: arrayGenderButtons[0], array: arrayGenderButtons)
        self.blockOrActionButtonsArray(arrayGenderButtons, andBlock: true)
        Singleton.shared.searchParams?.hGender = ""
        OtherMethods.updateUserDefaultsWithKey(key: Constants.keyHGender, andData: "")
    }
    
    public func unblockButtonsGender () {
        self.blockOrActionButtonsArray(arrayGenderButtons, andBlock: false)
    }
    
    public func blockButtonsAge () {
        checkButtonOnColor(button: arrayAgeButtons[0], array: arrayAgeButtons)
        self.blockOrActionButtonsArray(arrayAgeButtons, andBlock: true)
        self.arrayButtonsHumanActiv.removeAll()
        Singleton.shared.searchParams?.hAgeRange = self.convertArrayIndexToDiaposon(arrayIndex: [0])
        OtherMethods.updateUserDefaultsWithKey(key: Constants.keyHAgeRange, andData: self.convertArrayIndexToDiaposon(arrayIndex: [0]))
    }
    
    public func unblockButtonsAge () {
        self.blockOrActionButtonsArray(arrayAgeButtons, andBlock: false)
    }
    
    //MARK: - Private Methods
    
    private func blockOrActionButtonsArray (_ buttonsArray: [UIButton], andBlock block: Bool) {
        for button in buttonsArray {
            if block {
                button.isUserInteractionEnabled = false
            } else {
                button.isUserInteractionEnabled = true
            }
        }
    }
    
    private func addCollectionHimanAgeWithButton (_ sender: UIButton) {
        let index = self.searchIndexForButtonArray(arrayAgeButtons, andActionButton: sender)
        // FIXME: Доработать норамальную логику выборки
        if index == 0 {
            checkButtonOnColor(button: sender, array: arrayAgeButtons)
            self.arrayButtonsHumanActiv.removeAll()
        } else {
            if self.arrayButtonsHumanActiv.count == 0 {
                self.arrayButtonsHumanActiv.append(index)
                checkButtonOnColor(button: sender, array: arrayAgeButtons)
            } else {
                if !self.arrayButtonsHumanActiv.contains(where: {$0 == index}) {
                    if self.arrayButtonsHumanActiv.count == 1 && self.arrayButtonsHumanActiv[0] + 1 == index || self.arrayButtonsHumanActiv[0] - 1 == index {
                        self.arrayButtonsHumanActiv.append(index)
                    } else {
                        guard self.arrayButtonsHumanActiv.count != 1 else {
                            self.arrayButtonsHumanActiv.removeAll()
                            self.arrayButtonsHumanActiv.append(index)
                            checkButtonOnColor(button: sender, array: arrayAgeButtons)
                            return
                        }
                        if self.arrayButtonsHumanActiv[0] - 1 == index || self.arrayButtonsHumanActiv[self.arrayButtonsHumanActiv.count - 1] + 1 == index {
                            self.arrayButtonsHumanActiv.append(index)
                        } else {
                            self.arrayButtonsHumanActiv.removeAll()
                            self.arrayButtonsHumanActiv.append(index)
                            checkButtonOnColor(button: sender, array: arrayAgeButtons)
                        }
                    }
                    self.arrayButtonsHumanActiv = self.arrayButtonsHumanActiv.sorted()
                    //metod
                    self.checkButtonsForActions(array: self.arrayButtonsHumanActiv)
                } else {
                    self.arrayButtonsHumanActiv = self.arrayButtonsHumanActiv.filter{$0 == index}
                    checkButtonOnColor(button: sender, array: arrayAgeButtons)
                }
                
            }
        }
    }
    
    //Suport methods for realize logical choose human age--------------

    private func checkButtonsForActions (array: [Int]) {
        let startIndex = Int (array.first!)
        let endIndex = Int (array.last!)
        for (index, button) in self.arrayAgeButtons.enumerated() {
            if index >= startIndex && index <= endIndex {
                button.backgroundColor = #colorLiteral(red: 0.3843137255, green: 0.4549019608, blue: 0.5098039216, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.8274509804, blue: 0.8666666667, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 0.2235294118, green: 0.2941176471, blue: 0.3450980392, alpha: 1), for: .normal)
            }
        }
    }
    
    private func convertArrayIndexToDiaposon (arrayIndex: [Int]) -> [Int] {
        if arrayIndex.count == 0 {
            return [0, 0]
        } else if arrayIndex.count == 1 {
            return self.convertIndexToArrayAge(index: arrayIndex[0])!
        } else {
            let startElement = self.convertIndexToArrayAge(index: arrayIndex.first!)![0]
            let lastElement = self.convertIndexToArrayAge(index: arrayIndex.last!)![1]
            return [startElement, lastElement]
        }
    }
    
    private func convertIndexToArrayAge (index: Int) -> [Int]? {
        if let key = OtherMethods.getKeyForIndex(value: index, andDictionary: StaticDictionaries.dictionaryMyAge) {
            if let diaposonAge = ConvertorTypes.convertStringToArrayNumbers(string: key) {
                return diaposonAge
            }
        }
        return nil
    }
    
    private func checkWithAutorizationManyItems (searchParam: String) {
        let startArray = ConvertorTypes.convertStringToArrayNumbers(string: searchParam)!
        for (key, value) in StaticDictionaries.dictionaryMyAge {
            if value != 0 {
              let arrayKey = ConvertorTypes.convertStringToArrayNumbers(string: key)!
                if arrayKey[0] >= startArray[0] && arrayKey[1] <= startArray[1] {
                    arrayButtonsHumanActiv.append(value)
                }
            }
        }
        arrayButtonsHumanActiv = arrayButtonsHumanActiv.sorted()
        checkButtonsForActions(array: arrayButtonsHumanActiv)
    }
    
    //----------------------------------------------------------
    
    
    //MARK: Action and Changes
    @IBAction func actionGenderButtons(_ sender: UIButton) {
        checkButtonOnColor(button: sender, array: arrayGenderButtons)
        let index = self.searchIndexForButtonArray(arrayGenderButtons, andActionButton: sender)
        if let key = OtherMethods.getKeyForIndex(value: index, andDictionary: StaticDictionaries.dictionaryGender) {
            // FIXME: Доработать норамальную логику выборки
            if mySearch {
                Singleton.shared.searchParams?.mGender = key
                OtherMethods.updateUserDefaultsWithKey(key: Constants.keyMGender, andData: key)
            } else {
                Singleton.shared.searchParams?.hGender = key
                OtherMethods.updateUserDefaultsWithKey(key: Constants.keyHGender, andData: key)
            }
            //------------------------------------------
        }
        guard self.delegate != nil else { return }
        self.delegate!.didPressCellGender(cell: self)
    }
    
    @IBAction func actionAgeButtons(_ sender: UIButton) {
        if mySearch {
            checkButtonOnColor(button: sender, array: arrayAgeButtons)
            let index = self.searchIndexForButtonArray(arrayAgeButtons, andActionButton: sender)
            if let key = OtherMethods.getKeyForIndex(value: index, andDictionary: StaticDictionaries.dictionaryMyAge) {
                if let arrayAge = ConvertorTypes.convertStringToArrayNumbers(string: key) {
                    // FIXME: Доработать норамальную логику выборки
                    Singleton.shared.searchParams?.mAgeRange = arrayAge
                    OtherMethods.updateUserDefaultsWithKey(key: Constants.keyMAgeRange, andData: arrayAge)
                }
            }
        } else {
            self.addCollectionHimanAgeWithButton(sender)
            if self.arrayButtonsHumanActiv.count == 0 {
                Singleton.shared.searchParams?.hAgeRange = self.convertArrayIndexToDiaposon(arrayIndex: [0])
                OtherMethods.updateUserDefaultsWithKey(key: Constants.keyHAgeRange, andData: self.convertArrayIndexToDiaposon(arrayIndex: [0]))
            } else {
                Singleton.shared.searchParams?.hAgeRange = self.convertArrayIndexToDiaposon(arrayIndex: self.arrayButtonsHumanActiv)
                OtherMethods.updateUserDefaultsWithKey(key: Constants.keyHAgeRange, andData: self.convertArrayIndexToDiaposon(arrayIndex: self.arrayButtonsHumanActiv))
            }
        }
        guard self.delegate != nil else { return }
        self.delegate!.didPressCellAge(cell: self)
    }
}



