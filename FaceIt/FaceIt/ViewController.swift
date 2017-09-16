//
//  ViewController.swift
//  FaceIt
//
//  Created by Mac_Work on 16.09.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            updateUI()
        }
    }

    var expression = FacialExpression(eyes: .closed, mouth: .grin) {
        didSet {
            updateUI()
        }
    }
    private let mouthCurvatures = [FacialExpression.Mouth.grin: 0.5,
                                   .frown: -1.0,
                                   .smile: 1.0,
                                   .neutral: 0.0,
                                   .smirk: -0.5]
    private func updateUI() {
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
}

