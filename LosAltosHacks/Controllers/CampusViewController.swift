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
    @IBOutlet weak var pageControl: UIPageControl!

    // TODO: Add gestures for zoom/pan

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupMapViews()
    }

    override func setupConstraints() {

        scrollView.snp_makeConstraints { make in
            make.left.equalTo(view.snp_left).offset(20)
            make.right.equalTo(view.snp_right).offset(-20)
            make.center.equalTo(view.snp_center)
            make.height.equalTo(scrollView.snp_width)
        }

        pageControl.snp_makeConstraints { make in
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
            make.centerX.equalTo(view.snp_centerX)
        }
    }

    func setupMapViews() {
        let maps = [UIImage(named: "floor2"), UIImage(named: "floor2")]
        scrollView.pagingEnabled = true
        let width = self.view.frame.size.width - 2 * 20

        scrollView.contentSize = CGSizeMake(CGFloat(maps.count) * width,
                                            width)
        let mapViews = maps.map { UIImageView(image: $0) }
        mapViews.enumerate().forEach { index, view in

            view.frame = CGRectMake(CGFloat(index) * width, 0, width, width)

            view.contentMode = .ScaleAspectFit
            scrollView.addSubview(view)
        }
    }

}
