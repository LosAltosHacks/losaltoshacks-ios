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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone(identifier: "PST")!
        
        dateLabel.text = formatter.string(from: self.event.time as Date)
        
        locationLabel.text = event.location
        
        leftSplotch.backgroundColor = event.tag.color.value
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        dateLabel.sizeToFit()
        locationLabel.sizeToFit()

        setupConstraints()
    }

    func setupConstraints() {}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
