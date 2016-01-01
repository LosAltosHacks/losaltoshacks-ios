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

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupConstraints()
    }

    func setupConstraints() {
        descriptionLabel.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width)

            make.leftMargin.equalTo(self.snp_leftMargin).offset(10)
            make.topMargin.equalTo(self.snp_topMargin)
        }
        
        dateLabel.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width)
            
            make.leftMargin.equalTo(descriptionLabel.snp_leftMargin)
            make.top.equalTo(descriptionLabel.snp_bottom)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
