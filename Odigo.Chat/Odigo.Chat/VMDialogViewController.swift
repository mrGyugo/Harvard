//
//  VMDialogViewController.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 15.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import Lottie

class VMDialogViewController: VMMainViewController {
    
    var animationView: LOTAnimationView? = LOTAnimationView(name: "demo");

    override func viewDidLoad() {
        super.viewDidLoad()
        if let animationView = animationView {
            animationView.contentMode = .scaleAspectFill
            animationView.frame = self.view.bounds
            self.view.addSubview(animationView)
            animationView.play{ (finished) in
                
            }
            animationView.loopAnimation = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        
    }
    
    deinit {
        print("By Dialog")
    }


}
