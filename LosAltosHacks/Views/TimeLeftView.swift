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
        timeRemainingLabel.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).dividedBy(1.5)
        }

        countdownLabel.snp.makeConstraints { make in
            make.top.equalTo(timeRemainingLabel.snp.bottomMargin).offset(-4)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(240)
            make.height.equalTo(80)
        }

        hourLabel.snp.makeConstraints { make in
            make.centerY.equalTo(countdownLabel.snp.centerY)
            make.right.equalTo(countdownLabel.snp.left).offset(16)
        }

        minuteLabel.snp.makeConstraints { make in
            make.centerY.equalTo(countdownLabel.snp.centerY)
            make.left.equalTo(countdownLabel.snp.right).offset(-18)
        }

        progressView.snp.makeConstraints { make in
            make.top.equalTo(countdownLabel.snp.bottomMargin)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width)
                .dividedBy(1.2)
            make.height.equalTo(44)
        }
    }

    func initializeTimer() {

        // Time leading up to LAH
        if Date().isEarlierThanDate(.startDate) {
            timeRemainingLabel.text = "TIME UNTIL LOS ALTOS HACKS"
        }

        progressView.startProgress(startDate: .startDate, endDate: .endDate) {
            self.countdownLabel.text = $0.hour + ":" + $0.minute
        }
    }

}
