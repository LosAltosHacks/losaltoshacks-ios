//
//  UpcomingEventView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/11/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class UpcomingEventView: BaseView {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        descriptionLabel.numberOfLines = 0
    }

    override func setupConstraints() {
        sectionLabel.snp_makeConstraints { make in
            make.top.equalTo(10)
            make.height.equalTo(44)
            make.centerX.equalTo(self.snp_centerX)
        }

        clockImage.snp_makeConstraints { make in
            make.top.equalTo(sectionLabel.snp_bottom).offset(10)
            make.left.equalTo(self.snp_left).offset(40)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }

        timeLabel.snp_makeConstraints { make in
            make.centerY.equalTo(clockImage.snp_centerY)
            make.right.equalTo(self.snp_centerX)
            make.height.equalTo(32)
            make.left.equalTo(clockImage.snp_right).offset(5)
        }

        mapImage.snp_makeConstraints { make in
            make.centerY.equalTo(clockImage.snp_centerY)
            make.left.equalTo(self.snp_centerX).offset(5)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }

        locationLabel.snp_makeConstraints { make in
            make.centerY.equalTo(clockImage.snp_centerY)
            make.height.equalTo(32)
            make.left.equalTo(mapImage.snp_right).offset(5)
        }

        descriptionLabel.snp_makeConstraints { make in
            make.left.equalTo(clockImage.snp_left)
            make.right.equalTo(self.snp_right).offset(-40)
            make.height.equalTo(40)
            make.top.equalTo(clockImage.snp_bottom).offset(5)
        }
    }

}
