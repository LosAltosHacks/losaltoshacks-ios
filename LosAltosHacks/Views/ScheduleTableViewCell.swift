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
        titleLabel.text = event.event
        descriptionLabel.text = nil
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = NSTimeZone(name: "PST")!
        
        dateLabel.text = formatter.stringFromDate(self.event.time)
        
        locationLabel.text = event.location
        
        leftSplotch.backgroundColor = event.tag.color.value
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

    func setupConstraints() {}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}