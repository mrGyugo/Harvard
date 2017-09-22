//
//  VMHeaderView.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 16.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

@IBDesignable class VMHeaderView: UIView {
    
    // Our custom view from the XIB file
    var view: UIView!
    
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var dialogButton: UIButton!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var markerView: UIView!
    @IBOutlet weak var centerMarkerView: NSLayoutConstraint!
    
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
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "VMHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
