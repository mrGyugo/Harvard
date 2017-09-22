//
//  AvatarListController.swift
//  Odigo.Chat
//
//  Created by Мишустин Сергеевич on 14.07.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import SDWebImage

class AvatarListController: VMMainViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet private weak var buttonChoose: UIButton!
    @IBOutlet private weak var navigationCustomView: UIView!
    @IBOutlet private weak var collectionViewAvatars: UICollectionView!
    private var arrayAvatars: [Avatar] = []
    private var callBack: AvatarBlock?
    private var bigImageAvatar: UIImageView!
    private var backRect: CGRect!
    private var needAvatar: Avatar!
    private var isFullAction = false
    private var needImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewAvatars.register(UINib.init(nibName: "AvatarCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionViewAvatars.showsVerticalScrollIndicator = false
        bigImageAvatar = UIImageView(frame: self.view.bounds)
        bigImageAvatar.backgroundColor = UIColor.black
        bigImageAvatar.alpha = 0;
        bigImageAvatar.contentMode = .scaleAspectFit
        self.buttonChoose.alpha = 0
        self.view.addSubview(bigImageAvatar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reload()
    }
    
    //MARK: - Private Methods
    private func reload () {
        APIMeteor.getAvatars { (avatars) in
            self.arrayAvatars = avatars
            self.collectionViewAvatars.reloadData()
        }
    }
    
    //MARK: - Publick Methods
    public func updateControllerWithBlock (_ callBack: @escaping AvatarBlock) {
        self.callBack = callBack
    }
    
    
    //MARK - Actions and Changes
    
    @IBAction func backAction(_ sender: UIButton) {
        if self.isFullAction {
            UIView.animate(withDuration: 0.1, animations: {
                self.bigImageAvatar.frame = self.backRect
                self.navigationCustomView.backgroundColor = #colorLiteral(red: 0.4823529412, green: 0.5490196078, blue: 0.6, alpha: 1)
                self.buttonChoose.alpha = 0
            }, completion: { (bool) in
                self.isFullAction = true
                self.collectionViewAvatars.isUserInteractionEnabled = true
                self.bigImageAvatar.alpha = 0
            })
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonChooseAction(_ sender: UIButton) {
        self.callBack!(self.needImage!)
        OtherMethods.setUserDefoltsAvatar(avatar: self.needAvatar)
        dismiss(animated: true, completion: nil)
    }

    //MARK - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayAvatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AvatarCell
        let avatar = arrayAvatars[indexPath.row]
        cell.updateImageWithAvatar(avatar: avatar, tempCallBack: callBack!)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newCell = collectionView.cellForItem(at: indexPath) as! AvatarCell
        self.needImage = newCell.imageAvatar.image
        self.needAvatar = newCell.avatar
        self.bigImageAvatar.sd_setImage(with: URL(string: (newCell.avatar?.big)!), placeholderImage: self.needImage)
        let frame = CGRect(x: newCell.frame.origin.x, y: newCell.frame.origin.y + 64 - collectionViewAvatars.contentOffset.y, width: newCell.frame.size.width, height: newCell.frame.size.height)
        self.backRect = frame
        self.isFullAction = true
        self.bigImageAvatar.frame = frame
        self.bigImageAvatar.image = newCell.imageAvatar.image
        self.bigImageAvatar.alpha = 1
        self.collectionViewAvatars.isUserInteractionEnabled = false
        self.bigImageAvatar.bringSubview(toFront: self.collectionViewAvatars)
        self.view.bringSubview(toFront: self.navigationCustomView)
        UIView .animate(withDuration: 0.1, animations: {
            self.bigImageAvatar.frame = UIScreen.main.bounds
            self.navigationCustomView.backgroundColor = UIColor.black
            self.buttonChoose.alpha = 1
        }, completion: { (bool) in })
    }
    
    //MARK - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.size.width / 2, height: self.view.bounds.size.width / 2);
    }
    
}
