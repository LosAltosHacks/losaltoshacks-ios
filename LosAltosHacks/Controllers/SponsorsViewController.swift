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
    
    // used to display the images sponsored images
    var pagedSponsorImages: [(image: UIImage, view: UIImageView?)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // images that will be displayed
        let images = [
            UIImage(named: "moxtra")!,
            UIImage(named: "moxtra")!
        ]
        
        // create an array of pairs of images and image views
        self.pagedSponsorImages = images.map { ($0, nil) }
        
        //tell the scrollview what dimensions it has to work with
        scrollView.contentSize = CGSize(
            width: view.frame.width * CGFloat(pagedSponsorImages.count),
            height: scrollView.frame.size.height
        )
        
        // load initial pages
        loadVisiblePages()
    }
    
    func loadPage(page: Int) {
        
        // if page is out of range, dont load it
        guard (0..<pagedSponsorImages.count).contains(page) else { return }
        
        // if image is already loaded, dont load it
        guard pagedSponsorImages[page].view == nil else { return }
        
        
        var frame = scrollView.bounds
        
        //set the bounds of the image
        frame.origin.x = view.frame.size.width * CGFloat(page)
        frame.origin.y = 64
        frame.size.width = view.frame.size.width
        
        //TODO: fix the fact that full screen can't be used
        frame.size.height = 60 //full size gets cut off, so i have to shrink it
        
        let newPage = UIImageView(image: pagedSponsorImages[page].image)
        newPage.contentMode = .ScaleToFill
        newPage.frame = frame
        
        scrollView.addSubview(newPage)
        
        pagedSponsorImages[page].view = newPage
    }
    
    func purgePage(page: Int) {
        
        //don't try and remove a page that doesn't exist
        guard (0..<pagedSponsorImages.count).contains(page) else { return }
        
        //if the view isn't already cleared, clear it
        if let pageView = pagedSponsorImages[page].view {
            pageView.removeFromSuperview()
            pagedSponsorImages[page].view = nil
        }
    }
    
    func getVisiblePage() -> Int {
        let pageWidth = view.frame.size.width

        return Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth)/(pageWidth * 2.0)))
    }
    
    func loadVisiblePages() {
        
        let page = getVisiblePage()
        
        pageControl.currentPage = page
        
        let firstPage = page - 1
        let lastPage = page + 1
        
        // purge all pages until firstPage
        if firstPage >= 0 { (0..<firstPage).forEach { purgePage($0) } }
        
        // load the pages
        (firstPage...lastPage).forEach { loadPage($0) }
        
        // purge all images from the last page onwards
        (lastPage+1..<pagedSponsorImages.count).forEach { purgePage($0) }
        
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


extension SponsorsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
    }
}
