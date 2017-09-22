//
//  LanguegesController.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 29.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class LanguegesController: VMMainViewController, UITableViewDelegate, UITableViewDataSource, StoreDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bottononstrain: NSLayoutConstraint!
    @IBOutlet private weak var buttonChangeAll: UIButton!
    
    private var updateClosure: LanguageBlock?
    private var languages: [Language] = []
    private var defaultLanguages: [Language] = []
    
    private var allLanguages: Int? = nil


    
    var items: [LanguageCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = #colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1)
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    //MARK: - Public Methods
    public func updateControllerWithLanguages (_ languages: [Language], callBack: @escaping LanguageBlock) {
        updateClosure = callBack
        self.languages = languages
        self.defaultLanguages = self.languages
    }
    

    
    //MARK: - Private Methods
    
    private func reload () {
        APIMeteor.getLanguages { (languages) in
            self.items.removeAll()
            self.allLanguages = languages.count
            for language in languages {
                let cell = Bundle.main.loadNibNamed("LanguageCell", owner: self, options: nil)?.first as! LanguageCell
                cell.updateCellName(language)
                cell.checkOnUse(useListLanguages: self.languages)
                cell.delegate = self
                self.items.append(cell)
            }
            self.tableView.reloadData()
            self.checkOnButton()
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = items[indexPath.row]
        cell.updateCheckMark()
        return cell
    }
    
    //MARK: - Actions and Changes
    @IBAction private func actionButtonBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeAllLanguages(_ sender: UIButton) {
        if self.buttonChangeAll.titleLabel?.text == "Выбрать все" {
            self.checkAll(isBool: true)
        } else {
            self.checkAll(isBool: false)
        }
    }

    @IBAction func actionButtonSave(_ sender: UIButton) {
        self.updateClosure!(languages)
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - StoreDelegate
    func didPressButton(button: UIButton) {
        self.checkOnButton()
        if self.bottononstrain.constant != 0 {
            self.bottononstrain.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        if languages.count == 0 || self.languages == self.defaultLanguages {
            self.bottononstrain.constant = -70
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func addOrRemoveObject(language: Language, isBool: Bool) {
        if isBool {
            if !languages.contains(where: {$0.code == language.code}) {
                languages.append(language)
            }
        } else {
            self.languages = self.languages.filter{$0.code != language.code}
        }
    }
    
    //MARK: - Other
    
    func checkAll(isBool: Bool) {
        for item in items {
            item.isCkeckt = isBool
            item.updateCheckMark()
            item.updateLanguages()
        }
    }
    
    func checkOnButton() {
        if self.languages.count == self.allLanguages {
            self.buttonChangeAll.setTitle("Убрать все", for: .normal)
        } else {
            self.buttonChangeAll.setTitle("Выбрать все", for: .normal)
        }
    }
}





