//
//  VMTutorialViewController.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 04.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import SwiftDDP

class VMTutorialViewController: VMMainViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var slideScrollView: UIScrollView! {
        didSet {
            slideScrollView.isPagingEnabled = true
            slideScrollView.showsHorizontalScrollIndicator = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slides:[UIView] = createSlides()
        setupSlideScrollView(slides: slides)
    }
    
    //MARK: - For Slides
    
    private func createSlides () -> [UIView] {
        
        let slide1: VMFirstTutorialView = Bundle.main.loadNibNamed("VMFirstTutorialView", owner: self, options: nil)?.first as! VMFirstTutorialView
        slide1.buttonBegin.addTarget(self, action: #selector(actionButtonBegin), for: .touchUpInside)
        let slide2: VMSecondTutorialView = Bundle.main.loadNibNamed("VMSecondTutorialView", owner: self, options: nil)?.first as! VMSecondTutorialView
        slide2.buttonBegin.addTarget(self, action: #selector(actionButtonBegin), for: .touchUpInside)
        let slide3: VMThirdTutorialView = Bundle.main.loadNibNamed("VMThirdTutorialView", owner: self, options: nil)?.first as! VMThirdTutorialView
        slide3.buttonBegin.addTarget(self, action: #selector(actionButtonBegin), for: .touchUpInside)
        
        return [slide1, slide2, slide3]
    }
    
    private func setupSlideScrollView (slides: [UIView]) {
        
        slideScrollView.frame = CGRect(x: 0, y: 0,  width: view.frame.width,
                                       height: view.frame.height)
        slideScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count),
                                             height: view.frame.height)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height)
            slideScrollView.addSubview(slides[i])
        }
    }
    
    //MARK: - Actions
    func actionButtonBegin() {
        OtherMethods.setUserDefoltsTutorialWithBlock(keyUsrDefaults: Constants.userDefaultKeyForTutorial) {
            UIApplication.shared.isStatusBarHidden = false
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
