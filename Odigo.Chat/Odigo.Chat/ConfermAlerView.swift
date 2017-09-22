//
//  ConfermAlerView.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 19.07.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class ConfermAlerView: UIView {
    
    private var view: UIView!
    private var blockFirstConferm: AlertBlockConferm!
    private var blockSecondConferm: AlertBlockSecondConferm!
    private var blockThirdConferm: AlertBlockThirdConferm!
    
    
    @IBOutlet var collectionView: [UIView]!
    
    
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var mainText: UILabel!
    @IBOutlet private weak var buttonCansel: UIButton!
    
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    @IBOutlet private weak var thirdButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        view.backgroundColor = view.backgroundColor!.withAlphaComponent(0.6)
        addSubview(view)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubview(toBack: blurEffectView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ConfermAlerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    class func showAlerInfo (titleText: String, messageText: String, buttonCancelTitle: String) {
        let app = UIApplication.shared.delegate as! VMAppDelegate
        let window = app.window!
        let alert = ConfermAlerView(frame: window.bounds)
        alert.alpha = 0
        alert.firstButton.alpha = 0
        alert.secondButton.alpha = 0
        alert.thirdButton.alpha = 0
        alert.buttonCansel.setTitle(buttonCancelTitle, for: .normal)
        alert.titleLabel.text = titleText
        alert.mainText.text = messageText
        window.addSubview(alert)
        UIView.animate(withDuration: 0.3) {
            alert.alpha = 1
        }
    }
    
    class func showAlertConferm (titleText: String, messageText: String, buttonCancelTitle: String, buttonFirstTitle: String, confermBlock: @escaping AlertBlockConferm) {
        let app = UIApplication.shared.delegate as! VMAppDelegate
        let window = app.window!
        let alert = ConfermAlerView(frame: window.bounds)
        alert.alpha = 0
        alert.secondButton.alpha = 0
        alert.thirdButton.alpha = 0
        alert.buttonCansel.setTitle(buttonCancelTitle, for: .normal)
        alert.firstButton.setTitle(buttonFirstTitle, for: .normal)
        alert.titleLabel.text = titleText
        alert.mainText.text = messageText
        alert.blockFirstConferm = confermBlock
        window.addSubview(alert)
        UIView.animate(withDuration: 0.3) {
            alert.alpha = 1
        }
    }
    
    class func showAlertManyConferm (buttonCancelTitle: String, buttonFirstTitle: String, buttonSecondTitle: String, buttonThirdTitle: String, confermFirstBlock: @escaping AlertBlockConferm, confermSecondBlock: @escaping AlertBlockSecondConferm, confermThirdBlock: @escaping AlertBlockThirdConferm) {
        let app = UIApplication.shared.delegate as! VMAppDelegate
        let window = app.window!
        let alert = ConfermAlerView(frame: window.bounds)
        alert.alpha = 0
        alert.titleLabel.alpha = 0
        alert.mainText.alpha = 0
        alert.buttonCansel.setTitle(buttonCancelTitle, for: .normal)
        alert.firstButton.setTitle(buttonFirstTitle, for: .normal)
        alert.secondButton.setTitle(buttonSecondTitle, for: .normal)
        alert.thirdButton.setTitle(buttonThirdTitle, for: .normal)
        alert.blockFirstConferm = confermFirstBlock
        alert.blockSecondConferm = confermSecondBlock
        alert.blockThirdConferm = confermThirdBlock
        window.addSubview(alert)
        UIView.animate(withDuration: 0.3) {
            alert.alpha = 1
        }
    }
    
    @IBAction private func actionButtonCancel(_ sender: UIButton) {
        hideAlert()
    }
    
    @IBAction private func firstButtonAction(_ sender: UIButton) {
        self.blockFirstConferm!()
        hideAlert()
    }
    
    @IBAction func secondAlertAction(_ sender: UIButton) {
        self.blockSecondConferm!()
        hideAlert()

    }
    
    @IBAction func thirdAlertAction(_ sender: UIButton) {
        self.blockThirdConferm!()
        hideAlert()

    }
    
    
    private func hideAlert () {
        for view in collectionView { view.alpha = 0 }
        UIView.animate(withDuration: 0.3, animations: { self.alpha = 0 }) { (end) in
            self.removeFromSuperview()}
    }
    
}
