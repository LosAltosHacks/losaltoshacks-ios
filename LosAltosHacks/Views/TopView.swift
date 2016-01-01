//
//  TopView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/1/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class TopView: UIView {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        headerImageView.snp_makeConstraints { make in
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
            make.right.equalTo(self.snp_right)
            make.left.equalTo(self.snp_left)
        }

        upperLabel.snp_makeConstraints { make in
            make.center.equalTo(self.snp_center).offset(CGPointMake(0, -12.0))
        }

        titleLabel.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width)
            make.center.equalTo(self.snp_center).offset(CGPointMake(0, 12.0))
        }
    }
}
