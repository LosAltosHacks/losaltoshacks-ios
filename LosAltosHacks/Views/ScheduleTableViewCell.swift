//
//  UpdateTableViewCell.swift
//  LosAltosHacks
//
//  Created by Kyle Sandell on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SnapKit

class ScheduleTableViewCell: UITableViewCell, SnapKitView {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var mapImage: UIImageView!

    var event: EventParse? {
        didSet {
            if event != nil { // Guard against setting event = nil
                titleLabel.text = event!.title
                descriptionLabel.text = event!.detail
                dateLabel.text = LAHPreferredDisplay.from(event!.createdAt!)
                locationLabel.text = event!.location
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        dateLabel.sizeToFit()
        locationLabel.sizeToFit()

        setupConstraints()
    }

    func setupConstraints() {

        // TODO: Make this work
        //        dateLabel.snp_makeConstraints { make in
        //            make.width.equalTo(self.snp_width)
        //
        //            make.leftMargin.equalTo(descriptionLabel.snp_leftMargin)
        //            make.top.equalTo(self.snp_topMargin)
        //        }
        //
        //        descriptionLabel.snp_makeConstraints { make in
        //            make.width.equalTo(self.snp_width)
        //
        //            make.leftMargin.equalTo(self.snp_leftMargin).offset(10)
        //            make.top.equalTo(dateLabel.snp_bottom)
        //            make.bottom.equalTo(self.snp_bottom)
        //        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}