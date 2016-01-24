//
//  CampusViewController.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/23/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class CampusViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!

    // TODO: Add gestures for zoom/pan

    @IBAction func changeFloor(sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
        case 0:
            imageView.image = UIImage(named: "floor1")
        case 1:
            imageView.image = UIImage(named: "floor2")
        default:
            imageView.image = nil
        }

        scrollView.zoomScale = 1.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0

        segmentedControl.layer.cornerRadius = 5.0

        imageView.contentMode = .ScaleAspectFit
        imageView.userInteractionEnabled = true

//        setupMapViews()
    }

    override func setupConstraints() {

        scrollView.snp_makeConstraints { make in
            make.left.equalTo(view.snp_left).offset(15)
            make.right.equalTo(view.snp_right).offset(-15)
//            make.center.equalTo(view.snp_center)
            make.centerY.equalTo(view.snp_centerY)
            make.bottom.equalTo(snp_bottomLayoutGuideTop).offset(-10)
//            make.top.equalTo(segmentedControl.snp_bottom).offset(10)
        }

        segmentedControl.snp_makeConstraints { make in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(10)
            make.centerX.equalTo(view.snp_centerX)
        }

        imageView.snp_makeConstraints { make in
            make.top.equalTo(scrollView.snp_top)
            make.left.equalTo(scrollView.snp_left)
            make.bottom.equalTo(scrollView.snp_bottom)
            make.right.equalTo(scrollView.snp_right)
        }
    }

//    func setupMapViews() {
//        let maps = [UIImage(named: "floor2"), UIImage(named: "floor2")]
//
////        scrollView.pagingEnabled = true
//
//        let width = self.view.frame.size.width - 2 * 10
//
//        scrollView.contentSize = CGSizeMake(CGFloat(maps.count) * width,
//                                            width)
////        let mapViews = maps.map { GestureImageView(image: $0) }
//        maps.enumerate().forEach { index, mapImage in
//            let view = UIImageView(image: mapImage!)
//            view.frame = CGRectMake(CGFloat(index) * width + 10, 0, width - 20, width)
//            scrollView.addSubview(view)
//        }
//    }

}

extension CampusViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}