//
//  AppDelegate.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 04.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import SwiftDDP
import CoreData


@UIApplicationMain
class VMAppDelegate: UIResponder, UIApplicationDelegate {
    
        let mainURL = "wss://staging1.odigo.chat/websocket"
//    let mainURL = "ws://192.168.20.43:3000/websocket"

    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.backgroundColor = .white
        
        MamagerPersonalData.loadAvatar()
        MamagerPersonalData.loadSearchParams()

//        requests.delegate = self
        //ConnectMeteor-------
        Meteor.client.allowSelfSignedSSL = false
        Meteor.client.logLevel = .none
        Meteor.connect(self.mainURL) {
            
            Meteor.subscribe("statistics.all")

            guard Meteor.client.user() == nil else {
                MamagerPersonalData.autorization()
                Meteor.subscribe("pickups.my")
                return }
            if Meteor.client.loginWithToken({ (response, error) in }) {
                MamagerPersonalData.autorization()
            } else {
                if UserDefaults.standard.value(forKey: Constants.keyAccountSecretKey) != nil {
                    Meteor.client.loginWithUsername(OtherMethods.getDataInUserDefaultsWithKey(Constants.keyAccountName) as! String,
                                                    password: OtherMethods.getDataInUserDefaultsWithKey(Constants.keyAccountSecretKey) as! String, callback: { (responce, error) in
                                                        if responce != nil {
                                                            MamagerPersonalData.autorization()
                                                        }
                    })
                } else {
                    print("Ошибка авторизации")
                    //My language------
                    let languages = Locale.current.languageCode
                    let locale = NSLocale(localeIdentifier: languages!)
                    let translated = locale.displayName(forKey: NSLocale.Key.identifier, value: languages!)!
                    let curentLanguage = Language(code: languages!, name: translated.capitalized)
                    Singleton.shared.searchParams = SearchParams()
                    Singleton.shared.searchParams!.language = [curentLanguage]
                }
            }
        }
        return true
    }
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
