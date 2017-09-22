//
//  VMBaseViewController.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 04.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import PageMenu
import SwiftDDP


class VMBaseViewController: UIViewController, CAPSPageMenuDelegate {
    
    var pageMenu : CAPSPageMenu?
    var arrayButtons : [UIButton?] = []
    @IBOutlet weak var headerView: VMHeaderView!
    @IBOutlet weak var mainView: UIView!
    var controllerArray : [UIViewController] = []
    
    //Initialization-----------------
    override func viewDidLoad() {
        super .viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        
        
        //Check on tutorial----------
        let wasIntroWatched = UserDefaults.standard.bool(forKey: Constants.userDefaultKeyForTutorial)
        if !wasIntroWatched {
            if let tutorialVC = storyboard?.instantiateViewController(withIdentifier: "VMTutorialViewController")
                as? VMTutorialViewController {
                self.present(tutorialVC, animated: false, completion: nil)
            }
        }
    }
    
    
    
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if pageMenu == nil {

            //Main------------
            let mainController = VMMainVController(nibName: "VMMainVController", bundle: nil)
            controllerArray.append(mainController)
            //Dialog----------
            let dialogController = VMDialogViewController(nibName: "VMDialogViewController", bundle: nil)
            controllerArray.append(dialogController)
            //Friends---------
            let friendsController = VMFriendsViewController(nibName: "VMFriendsViewController", bundle: nil)
            controllerArray.append(friendsController)
        

            // Customize menu (Optional)
            let parameters: [CAPSPageMenuOption] = [
                .menuHeight(64.0),
                .menuItemWidth(90.0),
                .centerMenuItems(true),
                .hideTopMenuBar(true)
            ]
            
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 64.0, width: self.view.frame.width, height: self.view.frame.height - 64), pageMenuOptions: parameters)
            

            self.addChildViewController(pageMenu!)
            pageMenu?.delegate = self
            self.view.addSubview(pageMenu!.view)
            pageMenu!.didMove(toParentViewController: self)

            //Array for animations at index
            arrayButtons += [headerView.mainButton, headerView.dialogButton, headerView.friendsButton]
            for button in arrayButtons {
                button?.addTarget(self, action: #selector(actionButtonSlide), for: .touchUpInside)
            }
        }
    }

    //MARK: - CAPSPageMenuDelegate
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        animationMarkerView(index: index)
    }
    
    //MARK: - Actions
    func actionButtonSlide(sender: UIButton)  {
        for (index, button) in arrayButtons.enumerated() {
            if button == sender {
                animationMarkerView(index: index)
                pageMenu?.moveToPage(index)
            }
        }
    }
    
    //MARK: - Animation 
    func animationMarkerView(index: Int) {
        self.headerView.layoutIfNeeded()
        headerView.centerMarkerView.constant = headerView.mainButton.frame.width * CGFloat(index)
        UIView.animate(withDuration: 0.3, animations: {
            self.headerView.layoutIfNeeded()
            
        })
    }
}


