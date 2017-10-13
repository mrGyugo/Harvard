//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by Mac_Work on 11.10.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {
    
    var blinking = false {
        didSet {
            blinkIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        blinking = false
    }
    
    
    
    private func blinkIfNeeded() {
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closedDuration, repeats: false) { [weak self] timer in
                self?.faceView.eyesOpen = true
                Timer.scheduledTimer(withTimeInterval: BlinkRate.openDuraction, repeats: false) { [weak self] timer in
                    self?.blinkIfNeeded()
                }
            }
        }
    }
    
    private struct BlinkRate {
        static let closedDuration: TimeInterval = 0.4
        static let openDuraction: TimeInterval = 2.5
    }


}
