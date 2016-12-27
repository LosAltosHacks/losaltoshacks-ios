//
//  UpdateTableViewCell.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SnapKit

class UpdateTableViewCell: UITableViewCell, SnapKitView {

    var update: Update! {
        didSet {
            self.updateContent()
        }
    }
    
    func updateContent() {
        titleLabel.text = update.title
        descriptionLabel.text = update.description
        dateLabel.text = LAHPreferredDisplay.from(update.date)
        iconView.image = update.tag.image
        
        splotchView.backgroundColor = update.tag.color.value
    }

    @IBOutlet weak var splotchView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        splotchView.layer.cornerRadius = splotchView.frame.size.height / 2

        splotchView.contentMode = .scaleAspectFill
        splotchView.clipsToBounds = true
        
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()

        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()

//        self.layer.masksToBounds = false
//        self.layer.shadowOffset = CGSizeMake(0, 1)
//        self.layer.shadowRadius = 6
//        self.layer.shadowOpacity = 0.08

        setupConstraints()
    }

    func setupConstraints() {}
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
