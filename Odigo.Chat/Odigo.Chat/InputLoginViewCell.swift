//
//  InputLoginViewCell.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 13.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import SwiftDDP

enum CheckText: String {
    case inputLogin = "Только A-z от 5 до 20 символов"
    case loginCorrect = "Логин свободен"
    case loginBusy = "Логин занят"
    case loginDoNotCorrent = "Логин не корректен"
}

protocol InputLoginViewCellDelegate{
    func showKeyboard (inputCell: InputLoginViewCell)
    func hideKeyboard (inputCell: InputLoginViewCell)
}

class InputLoginViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet private weak var inputLogin: UITextField!
    @IBOutlet private weak var checkDescription: UILabel!
    @IBOutlet weak var buttonRegistration: UIButton!
    @IBOutlet weak var buttonEditor: UIButton!
    var delegate:InputLoginViewCellDelegate! = nil
    
    var clousure: AlertBlockConferm?
    var stateEditing = false
    
    var checkRegistrationButton = true
    var myProfile: AccountData? {
        get { return Singleton.shared.accountData }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputLogin.attributedPlaceholder = NSAttributedString(string: "Логин",
                                                              attributes: [NSForegroundColorAttributeName: #colorLiteral(red: 0.4823529412, green: 0.5490196078, blue: 0.6, alpha: 1)])
        inputLogin.delegate = self
    }
    
    
    //MARK: - Publick func
    public func updateAccountData () {
        guard let accountData = myProfile else { return }
        
        self.inputLogin.text = accountData.accountName
        self.changeAutorizationStatus(pozition: true)
    }
    
    public func addActionCheck (clousure: @escaping AlertBlockConferm) {
        self.clousure = clousure
    }
    
    //MARK: - Private Func
    
    private func changeAutorizationStatus (pozition: Bool) {
        if pozition {
            self.inputLogin.isUserInteractionEnabled = false
            self.buttonRegistration.setBackgroundImage(UIImage(named: "mainSlideDeleteNick"), for: .normal)
            self.buttonRegistration.alpha = 1
            self.buttonEditor.alpha = 1
            self.checkRegistrationButton = false
            self.checkDescription.alpha = 0
        } else {
            self.inputLogin.isUserInteractionEnabled = true
            self.buttonRegistration.setBackgroundImage(UIImage(named: "mainSlideCreateNick"), for: .normal)
            self.buttonRegistration.alpha = 0
            self.buttonEditor.alpha = 0
            self.inputLogin.text = nil
            self.checkDescription.text = CheckText.inputLogin.rawValue
            self.checkRegistrationButton = true
            self.checkDescription.alpha = 1
        }
    }
    
    private func editingWithState (_ state: Bool) {
        if !state {
            inputLogin.isUserInteractionEnabled = true
            inputLogin.text = ""
            inputLogin.becomeFirstResponder()
            stateEditing = true
            checkDescription.alpha = 1
            buttonEditor.alpha = 0
            buttonEditor.setBackgroundImage(UIImage(named: "mainSlideCreateNick"), for: .normal)
        } else {
            inputLogin.isUserInteractionEnabled = false
            inputLogin.text = myProfile!.accountName
            stateEditing = false
            checkDescription.alpha = 0
            buttonEditor.alpha = 1
            buttonEditor.setBackgroundImage(UIImage(named: "editImage"), for: .normal)
        }
    }
    
    
    private func checkTextAndButton (_ button: UIButton) {
        guard self.inputLogin.text != "" else {
            self.checkDescription.text = CheckText.inputLogin.rawValue
            return
        }
        guard OtherMethods.checkText(regularExpressions: VMRegularExpressions.textLogin, text: inputLogin.text!) else {
            self.checkDescription.text = CheckText.loginDoNotCorrent.rawValue
            button.alpha = 0
            return }
        DispatchQueue.global(qos: .userInitiated).async {
            APIMeteor.checkName(name: self.inputLogin.text!, callBack: { (result, error) in
                DispatchQueue.main.async {
                    if let boolResult: Bool = result as? Bool, boolResult {
                        self.checkDescription.text = CheckText.loginBusy.rawValue
                        button.alpha = 0
                    } else {
                        self.checkDescription.text = CheckText.loginCorrect.rawValue
                        button.alpha = 1
                    }
                }
            })
        }
    }
    
    //MARK : - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate.showKeyboard(inputCell: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.hideKeyboard(inputCell: self)
        
        
        if stateEditing { editingWithState(true) }
    }
    
    
    //MARK: - Actions and Changes
    
    @IBAction func inputLoginDidChange(_ sender: UITextField) {
        if stateEditing {
            checkTextAndButton(buttonEditor)
        } else {
            checkTextAndButton(buttonRegistration)
        }
    }
    
    @IBAction func tempAutorization(_ sender: UIButton) {
        
        if stateEditing {
            inputLogin.resignFirstResponder()
        } else {
            
            if myProfile == nil {
                APIMeteor.registrationWithName(name: self.inputLogin.text!) { (response, error) in
                    guard error == nil else { return }
                    self.changeAutorizationStatus(pozition: true)
                    if self.clousure != nil { self.clousure!() }
                }
            } else {
                ConfermAlerView.showAlertConferm(titleText: "Уверены?", messageText: "Все данные будут удалены ( переписка, друзья и т.д. ) и логин будет освобожден", buttonCancelTitle: "НЕТ", buttonFirstTitle: "ДА", confermBlock: {
                    Meteor.call("users.deleteMyself", params: [], callback: { (response, error) in
                        guard error == nil else { return }
                        self.changeAutorizationStatus(pozition: false)
                        
                        Singleton.shared.accountData = nil
                    })
                })
            }
        }
    }
    
    @IBAction func actionButtonEditing(_ sender: UIButton) {

        if stateEditing {
            APIMeteor.changeName(name: inputLogin.text!, callBack: { (result, error) in
                guard error == nil else { print(error!); return }
                Singleton.shared.accountData?.accountName = self.inputLogin.text!
                OtherMethods.changeName(self.inputLogin.text!)
                self.inputLogin.resignFirstResponder()
                AlertViewInfo.showAlertInfo(titleText: "Логин изменен!", messageText: "При отсутствии активновти более 5-ти дней логин освобожнается!")})
        } else {
             editingWithState(stateEditing)
        }
    }
}
