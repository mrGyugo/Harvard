//
//  ViewController.swift
//  FaceIt
//
//  Created by Mac_Work on 16.09.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class FaceViewController: VCLLoggingViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            let swipeUpGestore = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpGestore.direction = .up
            faceView.addGestureRecognizer(swipeUpGestore)
            let swipeDownGester = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownGester.direction = .down
            faceView.addGestureRecognizer(swipeDownGester)
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
    
    
     //Gesters actions
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    
    func increaseHappiness() {
        expression = expression.happier
    }
    
    func decreaseHappiness() {
        expression = expression.sadder
    }
}

