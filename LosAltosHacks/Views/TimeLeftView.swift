//
//  TimeLeftView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/10/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class TimeLeftView: BaseView {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        initializeTimer()
    }

    override func setupConstraints() {
        timeRemainingLabel.snp_makeConstraints { make in
            make.top.equalTo(12)
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(self.snp_width).dividedBy(1.5)
        }

        countdownLabel.snp_makeConstraints { make in
            make.top.equalTo(timeRemainingLabel.snp_bottomMargin).offset(-4)
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(240)
            make.height.equalTo(80)
        }

        hourLabel.snp_makeConstraints { make in
            make.centerY.equalTo(countdownLabel.snp_centerY)
            make.right.equalTo(countdownLabel.snp_left).offset(16)
        }

        minuteLabel.snp_makeConstraints { make in
            make.centerY.equalTo(countdownLabel.snp_centerY)
            make.left.equalTo(countdownLabel.snp_right).offset(-18)
        }

        progressView.snp_makeConstraints { make in
            make.top.equalTo(countdownLabel.snp_bottomMargin)
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(self.snp_width)
                .dividedBy(1.2)
            make.height.equalTo(44)
        }
    }

    func initializeTimer() {

        // Time leading up to LAH
        if NSDate().isEarlierThanDate(LAHConstants.LAHStartDate) {
            timeRemainingLabel.text = "TIME UNTIL LOS ALTOS HACKS"
        }

        progressView.startProgress(LAHConstants.LAHStartDate, endDate: LAHConstants.LAHEndDate) {
            self.countdownLabel.text = $0.hour + ":" + $0.minute
        }
    }

}
