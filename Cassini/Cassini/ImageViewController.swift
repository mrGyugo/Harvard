//
//  ImageViewController.swift
//  Cassini
//
//  Created by Mac_Work on 20.09.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            scrollView?.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    var imageURL: URL? {
        
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
        
    }
    fileprivate var imageView = UIImageView()
    
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    
    private func fetchImage() {
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }

    
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        
        return imageView
        
        
    }
}
