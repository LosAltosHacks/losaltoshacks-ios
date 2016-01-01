//
//  SponsorsViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit
import SnapKit

class SponsorsViewController: BaseViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var pagedSponsorImages: [UIImage] = []//holds the image of each sponsor's logo
    var pagedSponsorImageViews: [UIImageView?] = []//array of views equal in size to pagedSponsorImages, used to display the images in pagedSponsorImages
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagedSponsorImages = [UIImage(named: "moxtra")!,UIImage(named: "moxtra")!]//don't have other images to use, but this will just be a long ass array of sponsor images
        let pageCount = pagedSponsorImages.count//get the number of pages we have to display to tell the page control
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        for _ in 0..<pageCount {
            pagedSponsorImageViews.append(nil)
        }
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: view.frame.width*CGFloat(pagedSponsorImages.count), height: pagesScrollViewSize.height)//tell the scrollview what dimensions it has to work with
        loadVisiblePages()//load initial pages
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadPage(page: Int)
    {
        if (page < 0 || page >= pagedSponsorImages.count) {
            //check if we are trying to access an image that is out of range, and quit if so
            return
        }
        if let pageView = pagedSponsorImageViews[page] {
            //nada, image already loaded
        } else {
            var frame = scrollView.bounds
            //set the bounds of the image
            frame.origin.x = view.frame.size.width * CGFloat(page)
            frame.origin.y = 64
            frame.size.width = view.frame.size.width
            //TODO: fix the fact that full screen can't be used
            frame.size.height = 60 //full size gets cut off, so i have to shrink it
            
            let newPageView = UIImageView(image:pagedSponsorImages[page]/*resizedImage*/)
            newPageView.contentMode = .ScaleToFill
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            pagedSponsorImageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        //don't try and remove a page that doesn't exist
        if page < 0 || page >= pagedSponsorImages.count {
            return
        }
        //if the view isn't already cleared, clear it
        if let pageView = pagedSponsorImageViews[page] {
            pageView.removeFromSuperview()
            pagedSponsorImageViews[page] = nil
        }
    }
    
    func loadVisiblePages() {
        let pageWidth = view.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth)/(pageWidth * 2.0)))
        pageControl.currentPage = page
        let firstPage = page - 1
        let lastPage = page + 1
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        for var index = lastPage + 1; index < pagedSponsorImages.count; ++index {
            purgePage(index)
        }
        
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
