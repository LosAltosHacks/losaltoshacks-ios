//
//  GestureImageView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/23/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class GestureImageView: UIScrollView, UIScrollViewDelegate {

    var imageView: UIImageView!

    init(image: UIImage, frame: CGRect) {

        super.init(frame: frame)

        imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFit
        imageView.frame = self.bounds
        imageView.userInteractionEnabled = true
        self.addSubview(imageView)

        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 6.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        print("test")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.userInteractionEnabled = true
    }

}
