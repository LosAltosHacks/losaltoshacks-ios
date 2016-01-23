//
//  MentorView.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SnapKit

class MentorView: BaseView {

    @IBOutlet weak var slackButton: SlackButton!
    @IBOutlet weak var helpLabel: UILabel!
    
    weak var slackButtonDelgate: SlackButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        slackButton.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
    }
    
    func tapped(sender: UIButton) {
        self.slackButtonDelgate?.onTap(sender as! SlackButton)
    }

    override func setupConstraints() {
        // Help text
        helpLabel.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width).multipliedBy(0.75)
            make.height.equalTo(21)
            
            make.center.equalTo(self.snp_center).offset(CGPoint(x: 0, y: -30))
//            make.top.equalTo(self.snp_top).offset(10)
        }
        
        // Slack button
        slackButton.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width).multipliedBy(0.8)
            make.height.equalTo(44)
            
            make.centerX.equalTo(helpLabel.snp_centerX)
            make.top.equalTo(helpLabel.snp_bottom).offset(15)
        }
    }
}
