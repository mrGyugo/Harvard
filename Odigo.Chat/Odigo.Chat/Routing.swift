//
//  Routing.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 29.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import Foundation
import UIKit

final class Routing {
    

    private init() { }
    // MARK: Shared Instance
    static let shared = Routing()
    
    func showLangueController(listLanguage: [Language], callBack: @escaping LanguageBlock) {
        let languageViewController = LanguegesController()
        languageViewController.updateControllerWithLanguages(listLanguage, callBack: callBack)
        if let topController = UIApplication.topViewController() {
            topController.present(languageViewController, animated: true, completion: nil)
        }
    }
    
    func showAvatarListController(callBack: @escaping AvatarBlock) {
        let avatarListViewController = AvatarListController()
        avatarListViewController.updateControllerWithBlock(callBack)
        if let topController = UIApplication.topViewController() {
            let nc = UINavigationController(rootViewController: avatarListViewController)
            topController.present(nc, animated: true, completion: nil)
        }
    }

}
