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

    var progress: CGFloat = 0.0 {
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
    @IBOutlet weak var maskingView: UIView!

    var cornerRadius: CGFloat = 8.0


    override func awakeFromNib() {
        super.awakeFromNib()

        // Constraints

        percentLabel.snp_makeConstraints { make in
            make.center.equalTo(self.snp_center)
            make.width.equalTo(self.snp_width).dividedBy(4.8)
        }

//        maskingView.layer.cornerRadius = 8.0
        maskingView.snp_makeConstraints { make in
            make.center.equalTo(self.snp_center)
            make.left.equalTo(self.snp_left).offset(9)
            make.right.equalTo(self.snp_right).offset(-9)
            make.top.equalTo(self.snp_top).offset(6)
            make.bottom.equalTo(self.snp_bottom).offset(-6)
        }
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        // Custom view code

        if self.hidden {
            return
        }

        cornerRadius = rect.size.height / 2 // rounded rect effect
        percentLabel.text = "\(Int(progress * 100))%"
        percentLabel.textColor = LAHConstants.defaultDarkGreyColor
        percentLabel.clipsToBounds = true
        percentLabel.layer.cornerRadius = percentLabel.frame.size.height / 2

        // Layer 

        self.layer.borderWidth = BorderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = LAHConstants.defaultGreyColor.CGColor

        // Inner Rect

//        maskingView.snp_updateConstraints { make in
//            let offset: CGFloat = progress * maskingView.frame.size.width
//            make.left.equalTo(self.snp_left).offset(offset)
//        }

        let offset = progress * maskingView.frame.size.width
        maskingView.frame = CGRectMake(maskingView.frame.origin.x + offset,
                                       maskingView.frame.origin.y,
                                       maskingView.frame.size.width - offset,
                                       maskingView.frame.size.height)

        let innerRect = CGRectMake(ProgressBarInset + 1,
                                   ProgressBarInset,
                                   rect.size.width - 2 * ProgressBarInset - 2,
                                   rect.size.height - 2 * ProgressBarInset)
        drawInnerRect(rect: innerRect)
    }

    func drawInnerRect(rect innerRect: CGRect) {

            let bezier = UIBezierPath(roundedRect: innerRect, cornerRadius: innerRect.size.height / 2)
            barTintColor.setFill()
            bezier.fill()

    }

    func updateProgressWithTimer(timer: NSTimer, startDate: NSDate, endDate: NSDate) {

        if NSDate().compare(startDate) == NSComparisonResult.OrderedAscending {

        }
    }

}
