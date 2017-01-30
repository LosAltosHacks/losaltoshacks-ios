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

        slackButton.addTarget(self, action: #selector(MentorView.tapped(_:)), for: .touchUpInside)
    }
    
    func tapped(_ sender: UIButton) {
        self.slackButtonDelgate?.onTap(sender as! SlackButton)
    }

    override func setupConstraints() {
        // Help text
        helpLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.75)
            make.height.equalTo(21)
            
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-30)
//            make.top.equalTo(self.snp.top).offset(10)
        }
        
        // Slack button
        slackButton.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(44)
            
            make.centerX.equalTo(helpLabel.snp.centerX)
            make.top.equalTo(helpLabel.snp.bottom).offset(15)
        }
    }
}
