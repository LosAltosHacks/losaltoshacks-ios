//
//  TopView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/1/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class TopView: BaseView {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setupConstraints() {
        headerImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.left)
        }
        
        upperLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(12)
        }
    }
}
