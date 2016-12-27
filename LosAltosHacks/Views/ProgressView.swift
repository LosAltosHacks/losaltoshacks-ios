//
//  ProgressView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/1/16.
//  Copyright © 2016 Los Altos Hacks. All rights reserved.
//

import UIKit

class ProgressView: BaseView {

    // MARK: Properties

    let ProgressBarInset: CGFloat = 8.0
    let BorderWidth: CGFloat = 1.5

    var progress: CGFloat = 0.0 {
        didSet {
            if progress < 0.0 {
                progress = 0.0
            } else if progress > 1.0 {
                progress = 1.0
            }
        }
    }

    // Color of interior progress bar
    var barTintColor: UIColor = LAHColor.defaultColor.value.withAlphaComponent(0.9)

    // Center label that shows the % of progress
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var maskingView: UIView!

    var cornerRadius: CGFloat = 8.0

    var originalWidth: CGFloat!
    
    override func setupConstraints() {
        percentLabel.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(self.snp.width).dividedBy(4.8)
        }
        
        //        maskingView.backgroundColor = UIColor.blackColor()
        maskingView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.left.equalTo(self.snp.left).offset(4)
            make.right.equalTo(self.snp.right).offset(-4)
            make.top.equalTo(self.snp.top).offset(6)
            make.bottom.equalTo(self.snp.bottom).offset(-6)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // Custom view code

        if self.isHidden {
            return
        }

        if originalWidth == nil {
            originalWidth = maskingView.frame.size.width - ProgressBarInset
        }

        cornerRadius = rect.size.height / 2 // rounded rect effect
        percentLabel.text = "\(Int(progress * 100))%"
        percentLabel.textColor = LAHColor.defaultDarkGreyColor.value
        percentLabel.clipsToBounds = true
        percentLabel.layer.cornerRadius = percentLabel.frame.size.height / 2

        // Layer 

        self.layer.borderWidth = BorderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = LAHColor.defaultGreyColor.value.cgColor

        // Inner Rect

        let offset = Int(progress * originalWidth) + Int(ProgressBarInset)
        maskingView.frame = CGRect(x: CGFloat(offset),
                                       y: maskingView.frame.origin.y,
                                       width: maskingView.frame.size.width,
                                       height: maskingView.frame.size.height)

        let innerRect = CGRect(x: ProgressBarInset + 1,
                                   y: ProgressBarInset,
                                   width: rect.size.width - 2 * ProgressBarInset - 2,
                                   height: rect.size.height - 2 * ProgressBarInset)
        drawInnerRect(rect: innerRect)
    }

    func drawInnerRect(rect innerRect: CGRect) {
        let bezier = UIBezierPath(roundedRect: innerRect, cornerRadius: innerRect.size.height / 2)
        barTintColor.setFill()
        bezier.fill()
    }

    func updateProgressWithTimer(_ timer: Timer, startDate: Date, endDate: Date) {

        if !Date().isEarlierThanDate(startDate) {
            let interval = endDate.timeIntervalSince(startDate)
            let progressedInterval = Date().timeIntervalSince(startDate)

            progress = CGFloat(progressedInterval / interval)
            self.setNeedsDisplay()
        }
    }
    
    typealias countdownInfo = (hour: String, minute: String)
    
    var onUpdate: ((countdownInfo) -> Void)!
    func startProgress(_ startDate: Date, endDate: Date, onUpdate: @escaping (countdownInfo) -> Void) {
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
            selector: #selector(ProgressView.tick(_:)), userInfo: nil, repeats: true)
        
        self.onUpdate = onUpdate
        
        tick(timer) // initial update
        
    }
    
    func tick(_ timer: Timer) {
        
        var timeLeft = LAHConstants.LAHEndDate.timeIntervalSinceNow
        
        // Update progress view
        if Date().isEarlierThanDate(LAHConstants.LAHStartDate) {
            timeLeft = LAHConstants.LAHStartDate.timeIntervalSinceNow
        } else {
            updateProgressWithTimer(timer, startDate: LAHConstants.LAHStartDate as Date, endDate: LAHConstants.LAHEndDate as Date)
        }
        
        if !Date().isEarlierThanDate(LAHConstants.LAHEndDate) && timer.isValid {
            timer.invalidate()
            onUpdate((hour: "00", minute: "00"))
            return
        }
        
        // Update label
        let hourString = timeLeft.hours < 10 ? "0\(timeLeft.hours)" : "\(timeLeft.hours)"
        let minuteString = timeLeft.minutes < 10 ? "0\(timeLeft.minutes)" : "\(timeLeft.minutes)"
        
        onUpdate((hour: hourString, minute: minuteString))
    }

}
