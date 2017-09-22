//
//  AvatarCell.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 14.07.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import SDWebImage

class AvatarCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet private weak var constainWith: NSLayoutConstraint!
    var avatar: Avatar? = nil
    private var imageLoadid = false
    private var callback: AvatarBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageAvatar.contentMode = .scaleAspectFit
    }
    
    //MARK - Public Func
    
    public func updateImageWithAvatar (avatar: Avatar, tempCallBack: @escaping AvatarBlock) {
        self.avatar = avatar
        self.callback = tempCallBack
        imageAvatar.sd_setImage(with: URL(string: avatar.medium!), placeholderImage: UIImage(named: "01-01.jpg") ,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            self.imageLoadid = true
            
        })
        imageAvatar.setShowActivityIndicator(true)
        imageAvatar.setIndicatorStyle(.gray)
        
    }
}
