//
//  AlertViewInfo.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 20.07.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class AlertViewInfo: UIView {

    private var view: UIView!
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var buttonConferm: UIButton!

    @IBOutlet private weak var constraintLeft: NSLayoutConstraint!
    @IBOutlet private weak var constraintRight: NSLayoutConstraint!
    
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
        let nib = UINib(nibName: "AlertViewInfo", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    class func showAlertInfo (titleText: String, messageText: String) {
        let app = UIApplication.shared.delegate as! VMAppDelegate
        let window = app.window!
        let alert = AlertViewInfo(frame: window.bounds)
        alert.alertView.alpha = 0
        alert.alertView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        alert.titleLabel.text = titleText
        alert.textLabel.text = messageText
        window.addSubview(alert)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5, options: [], animations: {
                        alert.alertView.alpha = 1
                        alert.alertView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @IBAction func buttonConfermAction(_ sender: UIButton) {
        
        self.alertView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (bool) in
            self.removeFromSuperview()
        }
        
        
    }

}
