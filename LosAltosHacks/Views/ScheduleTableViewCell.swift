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
    @IBOutlet weak var leftSplotch: UIView!

    var event: Event! {
        didSet {
            updateContent()
        }
    }
    
    func updateContent() {
        titleLabel.text = event.title
        descriptionLabel.text = event.detail
        
        print(event.from)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = NSTimeZone(name: "GMT")
        print(formatter.stringFromDate(event!.from))
        
        dateLabel.text = formatter.stringFromDate(self.event!.from)
        
        locationLabel.text = event.location
        
        let color = LAHConstants.Color(from: event.tag) ?? LAHConstants.Color.DefaultColor
        leftSplotch.backgroundColor = color.value
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