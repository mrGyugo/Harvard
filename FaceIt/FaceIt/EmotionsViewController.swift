//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Mac_Work on 19.09.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class EmotionsViewController: VCLLoggingViewController, UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.splitViewController?.delegate = self
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
        "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "worried" : FacialExpression(eyes: .open, mouth: .smirk)
    ]
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinatiomViewController = segue.destination
        
        if let navigationController = destinatiomViewController as? UINavigationController {
            destinatiomViewController = navigationController.visibleViewController ?? destinatiomViewController
        }
        
        
        if let faceViewcontroller = destinatiomViewController as? FaceViewController,
            let identifier = segue.identifier,
            let expression = emotionalFaces[identifier] {
            faceViewcontroller.expression = expression
            faceViewcontroller.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }

//    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
//        return self.navigationController
//    }
}
