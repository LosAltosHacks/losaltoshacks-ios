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

    var update: UpdateParse? {
        didSet {
            if update != nil {
                descriptionLabel.text = update?.content
                dateLabel.text = LAHPreferredDisplay.from(update!.createdAt!)
                iconView.image = UIImage(named: "logistics")
                if let tag = update?.tag {
                    iconView.image = UIImage(named: tag.lowercaseString)
                }
                splotchView.backgroundColor = LAHConstants.Color.DefaultColor.value
                if let color = LAHConstants.Color(from: update!.tag)?.value {
                    splotchView.backgroundColor = color
                }
            }
        }
    }

    @IBOutlet weak var splotchView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        splotchView.layer.cornerRadius = splotchView.frame.size.height / 2

        splotchView.contentMode = .ScaleAspectFill
        splotchView.clipsToBounds = true

        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()

//        self.layer.masksToBounds = false
//        self.layer.shadowOffset = CGSizeMake(0, 1)
//        self.layer.shadowRadius = 6
//        self.layer.shadowOpacity = 0.08

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
