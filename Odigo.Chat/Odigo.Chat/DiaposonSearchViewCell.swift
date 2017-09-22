//
//  DiaposonSearchViewCell.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 13.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import CoreData
import SwiftDDP

protocol DiaposonSearchViewCellDelegate {
    func didPressCell(cell:DiaposonSearchViewCell)
}

class DiaposonSearchViewCell: UITableViewCell {
    
    @IBOutlet private var arrayRangeButtons: [UIButton]!
    @IBOutlet private weak var labelOnlineCount: UILabel!
    @IBOutlet private weak var labelSearchCount: UILabel!
    @IBOutlet private weak var langueButton: UIButton!
    @IBOutlet private weak var labelLanguage: UILabel!
    @IBOutlet private weak var labelLocation: UILabel!
    
    var delegate:DiaposonSearchViewCellDelegate?
    
    var stringLanguages = ""

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Public Func
    public func updateLocation (locationString: String) {
        labelLocation.text = locationString
    }
    
    public func blockLocation () {
        for buttons in self.arrayRangeButtons {
            buttons.isUserInteractionEnabled = false
        }
    }
    
    public func unblockLocation () {
        for buttons in self.arrayRangeButtons {
            buttons.isUserInteractionEnabled = true
        }
    }
    
    public func updateUsers(nowOnline: String, search: String) {
        labelOnlineCount?.text = nowOnline
        labelSearchCount?.text = search
    }
    
    public func updateLanguages() {
        if Singleton.shared.searchParams?.language != nil {
            self.labelLanguage.text = self.listLanguagesWithString((Singleton.shared.searchParams?.language)!)
        }
    }
    
    public func checkParamsDiapason (searchParams: String, strunctDict dict: [String : Int]) {
        guard let nedeedIndexMyGender = dict[searchParams] else { return }
        self.serchButtonWithArray(self.arrayRangeButtons, andFindIndex: nedeedIndexMyGender)
    }
    
    
    //MARK: - Actions and Changes
    
    @IBAction private func actionRangeButtons(_ sender: UIButton) {
        checkButtonOnColor(button: sender, array: arrayRangeButtons)
        let index = self.searchIndexForButtonArray(arrayRangeButtons, andActionButton: sender)
        if let key = OtherMethods.getKeyForIndex(value: index, andDictionary: StaticDictionaries.dictionarySearch){
            if let searchRange = ConvertorTypes.convertStringToInt(string: key) {
                Singleton.shared.searchParams?.searchRange = searchRange
                OtherMethods.updateUserDefaultsWithKey(key: Constants.keySearchRenge, andData: searchRange)
            }
        }
    }
    
    @IBAction private func chooseLanguage(_ sender: Any) {
        
        Routing.shared.showLangueController(listLanguage: (Singleton.shared.searchParams?.language)!) { (languages) in
            self.stringLanguages = self.listLanguagesWithString(languages)
            self.labelLanguage.text = self.stringLanguages
            Singleton.shared.searchParams?.language = languages
            OtherMethods.updateUserDefaultsWithKey(key: Constants.keyLanguage, andData: OtherMethods.convertToString(languages: languages))
            
            
        }
    }
    
    @IBAction func serchInterlocutor(_ sender: UIButton) {
        
        
        guard delegate != nil else { return }
        self.delegate?.didPressCell(cell: self)
    }
    
    
    
    
    
    
    
    
    //MARK: - Other
    func listLanguagesWithString(_ languages: [Language]) -> String {
        var listLanguages = ""
        for language in languages {
            if listLanguages == "" {
                listLanguages = listLanguages + language.name
            } else {
                listLanguages = listLanguages + "," + language.name
            }
        }
        return listLanguages
    }
}
