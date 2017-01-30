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
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false

        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
    }

    override func setupConstraints() {
    }
}

extension CampusViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
