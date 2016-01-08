//
//  DashboardViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit
import SnapKit
import SafariServices

class DashboardViewController: BaseViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mentorView: MentorView!
//    @IBOutlet weak var scrollView: UIScrollView!
    
    // TODO: Put this all in a view
    @IBOutlet weak var timeLeftView: UIView!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var socialMediaView: SocialMediaView!
    @IBOutlet weak var socialMediaLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socialMediaView.delegate = self
        
        initializeTimer()
    }

    func initializeTimer() {

        // Time leading up to LAH
        if NSDate().isEarlierThanDate(LAHConstants.LAHStartDate) {
            timeRemainingLabel.text = "TIME UNTIL LOS ALTOS HACKS"
        }

        progressView.startProgress(LAHConstants.LAHStartDate, endDate: LAHConstants.LAHEndDate) {
            self.countdownLabel.text = $0.hour + ":" + $0.minute
        }
    }
    
    override func setupConstraints() {

//        scrollView.snp_makeConstraints { make in
//            make.top.equalTo(snp_topLayoutGuideBottom)
//            make.bottom.equalTo(snp_bottomLayoutGuideBottom)
//            make.left.equalTo(view.snp_left)
//            make.right.equalTo(view.snp_right)
//        }

        topView.snp_makeConstraints { make in
            make.height.equalTo(115)
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        mentorView.snp_makeConstraints { make in
            make.height.equalTo(view.snp_height)
                .dividedBy(5)
            
            make.centerX.equalTo(view.snp_centerX)
            
            make.left.equalTo(view.snp_left)
            make.top.equalTo(topView.snp_bottom)
        }

        timeLeftView.snp_makeConstraints { make in
            make.top.equalTo(mentorView.snp_bottom)
            make.height.equalTo(200)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        timeRemainingLabel.snp_makeConstraints { make in
            make.top.equalTo(12)
            make.centerX.equalTo(timeLeftView.snp_centerX)
            make.width.equalTo(view.snp_width).dividedBy(1.5)
        }

        countdownLabel.snp_makeConstraints { make in
            make.top.equalTo(timeRemainingLabel.snp_bottomMargin).offset(-4)
            make.centerX.equalTo(timeLeftView.snp_centerX)
            make.width.equalTo(240)
            make.height.equalTo(80)
        }

        hourLabel.snp_makeConstraints { make in
            make.centerY.equalTo(countdownLabel.snp_centerY)
            make.right.equalTo(countdownLabel.snp_left).offset(16)
        }

        minuteLabel.snp_makeConstraints { make in
            make.centerY.equalTo(countdownLabel.snp_centerY)
            make.left.equalTo(countdownLabel.snp_right).offset(-18)
        }

        progressView.snp_makeConstraints { make in
            make.top.equalTo(countdownLabel.snp_bottomMargin)
            make.centerX.equalTo(timeLeftView.snp_centerX)
            make.width.equalTo(timeLeftView.snp_width)
                .dividedBy(1.2)
            make.height.equalTo(timeLeftView.snp_height)
                .dividedBy(4)
        }

        socialMediaView.snp_makeConstraints { make in
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(45)
        }

        socialMediaLabel.snp_makeConstraints { make in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(socialMediaView.snp_topMargin).offset(-10)
        }

    }
}

extension BaseViewController: SocialMediaViewDelegate {
    func onTap(socialMedia: SocialMedia) {
        
        let safari = SFSafariViewController(URL: socialMedia.url)
        
        self.presentViewController(safari, animated: true, completion: nil)
    }
}
