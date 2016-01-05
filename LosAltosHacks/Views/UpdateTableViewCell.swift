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
