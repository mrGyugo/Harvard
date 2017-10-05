//
//  LanguageCell.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 29.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit


protocol StoreDelegate {
    func didPressButton(button:UIButton)
    func addOrRemoveObject(language: Language, isBool: Bool)
}

class LanguageCell: UITableViewCell {
    
    @IBOutlet private weak var languageName: UILabel!
    @IBOutlet private weak var checkMarkImage: UIImageView!
    @IBOutlet private weak var buttonCell: UIButton!
    
    
    var delegate:StoreDelegate!
    var isCkeckt = false
    var language : Language? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        checkMarkImage.alpha = 0
    }

    @IBAction private func actionTupCell(_ sender: Any) {
        
        if isCkeckt {
            isCkeckt = false
        } else {
            isCkeckt = true
        }
        updateCheckMark()
        delegate.addOrRemoveObject(language: self.language!, isBool: isCkeckt)
        delegate.didPressButton(button: sender as! UIButton)
    }
    
    //MARK: PublicFunc
    public func updateCellName(_ language : Language) {
        self.language = language
        languageName.text = language.name;
        isCkeckt = false
        
    }
    
    public func checkOnUse (useListLanguages: [Language]) {
        for language in useListLanguages {
            if self.language?.code == language.code {
                isCkeckt = true
                break
            }
        }
        updateCheckMark()
    }
    
    public func updateLanguages() {
        delegate.addOrRemoveObject(language: self.language!, isBool: isCkeckt)
        delegate.didPressButton(button: self.buttonCell)
    }
    
    public func updateCheckMark() {
        if self.isCkeckt {
           checkMarkImage.alpha = 1
        } else {
           checkMarkImage.alpha = 0
        }
    }
    
}
