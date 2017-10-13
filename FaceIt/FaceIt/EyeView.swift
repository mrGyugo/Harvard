//
//  EyeView.swift
//  FaceIt
//
//  Created by Mac_Work on 11.10.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class EyeView: UIView {
    
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }
    
    var eyesOpen: Bool = true { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        var path: UIBezierPath
        
        
        if eyesOpen {
            path = UIBezierPath(ovalIn: bounds.insetBy(dx: lineWidth/2,
                                                      dy: lineWidth/2))
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.midX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        }
        
        path.lineWidth = lineWidth
        color.setStroke()
        path.stroke()
    }
}
