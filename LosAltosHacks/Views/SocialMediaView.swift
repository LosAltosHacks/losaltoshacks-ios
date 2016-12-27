//
//  SocialMediaView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/1/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

protocol SocialMediaViewDelegate: class {
    func onTap(_ socialMedia: SocialMedia)
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
        facebookButton.addTarget(self, action: #selector(SocialMediaView.tapped(_:)), for: .touchUpInside)
        twitterButton.addTarget(self, action: #selector(SocialMediaView.tapped(_:)), for: .touchUpInside)
        instagramButton.addTarget(self, action: #selector(SocialMediaView.tapped(_:)), for: .touchUpInside)
    }
    
    func tapped(_ sender: UIButton) {
        
        let socialMedia: SocialMedia
        switch sender {
        case facebookButton:
            socialMedia = .facebook
        case twitterButton:
            socialMedia = .twitter
        case instagramButton:
            socialMedia = .instagram
        default:
            return
        }
        
        self.delegate?.onTap(socialMedia)
    }
    
    override func setupConstraints() {
        facebookButton.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(3)
            make.height.equalTo(self.snp.height)
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
        }
        
        twitterButton.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(3)
            make.height.equalTo(self.snp.height)
            make.left.equalTo(facebookButton.snp.right)
            make.top.equalTo(self.snp.top)
        }
        
        instagramButton.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(3)
            make.height.equalTo(self.snp.height)
            make.left.equalTo(twitterButton.snp.right)
            make.top.equalTo(self.snp.top)
        }
    }
}
