//
//  VMMainViewController.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 04.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import CoreData
import SwiftDDP

class VMMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeStatisticsNotification),
                                               name: Notification.Name.notificationChangeStatistics, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.changePickupsNotification),
                                               name: Notification.Name.notificationChangePickups, object: nil)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    func changeStatisticsNotification (notification: Notification) {}
    func changePickupsNotification (notification: Notification) {}


    
    
}



//MARK: - Public Exstentions
extension UITableViewCell {
    
    func checkButtonOnColor(button: UIButton, array:[UIButton]) {
        for tempButton in array {
            if tempButton == button {
                tempButton.backgroundColor = #colorLiteral(red: 0.3843137255, green: 0.4549019608, blue: 0.5098039216, alpha: 1)
                tempButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            } else {
                tempButton.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.8274509804, blue: 0.8666666667, alpha: 1)
                tempButton.setTitleColor(#colorLiteral(red: 0.2235294118, green: 0.2941176471, blue: 0.3450980392, alpha: 1), for: .normal)
            }
        }
    }
    
    //Поиск нужной кнопки для аторизации--------
    func serchButtonWithArray(_ array: [UIButton], andFindIndex tempIndex: Int) {
        for (index, button) in array.enumerated() {
            if index == tempIndex {
                button.backgroundColor = #colorLiteral(red: 0.3843137255, green: 0.4549019608, blue: 0.5098039216, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.8274509804, blue: 0.8666666667, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 0.2235294118, green: 0.2941176471, blue: 0.3450980392, alpha: 1), for: .normal)
            }
        }
    }
    
    //Поиск индекса по нажатию на кнпоку-------
    func searchIndexForButtonArray (_ buttonArray: [UIButton], andActionButton checkButton: UIButton) -> Int {
        for (index, tempButton) in buttonArray.enumerated() {
            if tempButton .isEqual(checkButton) {
                return index
            }
        }
        print("кнопка не найдена")
        return 0
    }
    
}

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}

// Put this piece of code anywhere you like
extension UIViewController: UIGestureRecognizerDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - UIGestureRecognizerDelegate
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view is UIButton {
            return false
        }
        return true
    }

}

