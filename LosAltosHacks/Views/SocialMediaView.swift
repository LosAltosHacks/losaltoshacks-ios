//
//  SocialMediaView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/1/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class SocialMediaView: BaseView {

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!

    override func setupConstraints() {
        facebookButton.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width).dividedBy(3)
            make.height.equalTo(self.snp_height)
            make.left.equalTo(self.snp_left)
            make.centerY.equalTo(self.snp_centerY)
        }
        
        twitterButton.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width).dividedBy(3)
            make.height.equalTo(self.snp_height)
            make.center.equalTo(self.snp_center)
        }
        
        instagramButton.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width).dividedBy(3)
            make.height.equalTo(self.snp_height)
            make.right.equalTo(self.snp_right)
            make.centerY.equalTo(self.snp_centerY)
        }
    }
}
