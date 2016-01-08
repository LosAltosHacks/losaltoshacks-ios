//
//  SocialMediaView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/1/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

protocol SocialMediaViewDelegate: class {
    func onTap(socialMedia: SocialMedia)
}

class SocialMediaView: BaseView {
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    
    weak var delegate: SocialMediaViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerListeners()
    }
    
    func registerListeners() {
        // because outlets are too much work...
        facebookButton.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
        twitterButton.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
        instagramButton.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
    }
    
    func tapped(sender: UIButton) {
        
        let socialMedia: SocialMedia
        switch sender {
        case facebookButton:
            socialMedia = .Facebook
        case twitterButton:
            socialMedia = .Twitter
        case instagramButton:
            socialMedia = .Instagram
        default:
            return
        }
        
        self.delegate?.onTap(socialMedia)
    }
    
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
