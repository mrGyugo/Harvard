//
//  HeaderViewCell.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 13.06.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import SDWebImage



class HeaderViewCell: UITableViewCell {
    
    @IBOutlet weak var changeAvatar: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        changeAvatar.backgroundColor = UIColor(white: 1, alpha: 0.4)
        if Singleton.shared.avatar?.medium != nil {
            changeAvatar.alpha = 0
            avatarImage.sd_setImage(with: URL(string: (Singleton.shared.avatar?.medium!)!))
            avatarImage.setShowActivityIndicator(true)
            avatarImage.setIndicatorStyle(.gray)
        } else {
            avatarImage.image = UIImage(named: "01-01.jpg")
        }
    }
    
    
    @IBAction func changeAvatarAction(_ sender: UIButton) {
        Routing.shared.showAvatarListController { [weak selfWeak = self] (image)  in
            selfWeak?.avatarImage.image = image
            selfWeak?.changeAvatar.alpha = 0
        }
    }
    
    @IBAction func BoxAction(_ sender: UIButton) {
        
        AlertViewInfo .showAlertInfo(titleText: "Внимание", messageText: "как дела ываыфваыфвафываsdfsdf asdfsa dfsad fsa dfas df asdf sdf?")
        
        
    }

}
