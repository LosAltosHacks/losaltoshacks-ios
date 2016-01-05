//
//  SponsorsViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit
import SnapKit

class SponsorsViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // images that will be displayed
        let images = [
            UIImage(named: "moxtra")!,
            UIImage(named: "moxtra")!,
            UIImage(named: "moxtra")!
        ]
        
        // tell the scrollview what dimensions it has to work with
        scrollView.bounces = false
        scrollView.contentSize = CGSize(
            width: view.frame.width * CGFloat(images.count),
            height: scrollView.frame.size.height
        )
        
        // create an array of pairs of images and image views
        let imageViews = images.map { UIImageView(image: $0) }
        
        // add each image view to the scrollview
        imageViews.enumerate().forEach { index, view in
            var frame = scrollView.bounds
            
            //set the bounds of the image
            frame.origin.x = self.view.frame.size.width * CGFloat(index)
            frame.origin.y = 64
            frame.size.width = self.view.frame.size.width
            
            frame.size.height = 60
            
            view.frame = frame
            
            scrollView.addSubview(view)
        }
    }
    
    override func setupConstraints() {
        
        scrollView.snp_makeConstraints { make in
            
            make.height.equalTo(view.snp_height).multipliedBy(0.2)
            make.width.equalTo(view.snp_width)
            
            make.centerX.equalTo(view.snp_centerX)
        }
        
        pageControl.snp_makeConstraints { make in
            make.top.equalTo(scrollView.snp_bottom)
            make.width.equalTo(view.snp_width)
        }
        
        tableContainer.snp_makeConstraints { make in
            
            make.height.equalTo(view.snp_height).multipliedBy(0.8)
            make.width.equalTo(view.snp_width)
            
            make.top.equalTo(pageControl.snp_bottom)
        }
    }
}
