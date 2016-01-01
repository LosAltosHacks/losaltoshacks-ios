//
//  ProgressView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/1/16.
//  Copyright © 2016 Los Altos Hacks. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    // MARK: Properties

    let ProgressBarInset: CGFloat = 8.0
    let BorderWidth: CGFloat = 1.5

    var progress: CGFloat = 0.8 {
        willSet(newProgress) {
            if newProgress < 0.0 || newProgress > 1.0 {
                return
            }
        }
    }

    // Color of interior progress bar
    var barTintColor: UIColor = LAHConstants.defaultColor.colorWithAlphaComponent(0.9)

    // Center label that shows the % of progress
    @IBOutlet weak var percentLabel: UILabel!

    var cornerRadius: CGFloat = 8.0

    override func drawRect(rect: CGRect) {
        // Custom view code

        if self.hidden {
            return
        }

        cornerRadius = rect.size.height / 2 // rounded rect effect
        percentLabel.text = "\(progress * 100)%"
        percentLabel.textColor = LAHConstants.defaultDarkGreyColor
        percentLabel.clipsToBounds = true
        percentLabel.layer.cornerRadius = percentLabel.frame.size.height / 2

        // Constraints

        percentLabel.snp_makeConstraints { make in
            make.center.equalTo(self.snp_center)
            make.width.equalTo(self.snp_width).dividedBy(4.8)
        }

        // Layer 

        self.layer.borderWidth = BorderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = LAHConstants.defaultGreyColor.CGColor

        // Inner Rect

        let innerRect = CGRectMake(ProgressBarInset + 1,
                                   ProgressBarInset,
                                   rect.size.width * progress - 2 * ProgressBarInset - 2,
                                   rect.size.height - 2 * ProgressBarInset)
        drawInnerRect(rect: innerRect)
    }

    func drawInnerRect(rect innerRect: CGRect) {

        let bezier = UIBezierPath(roundedRect: innerRect, cornerRadius: innerRect.size.height / 2)
        barTintColor.setFill()
        bezier.fill()

    }

//    func updateProgressWithTimer()

}
