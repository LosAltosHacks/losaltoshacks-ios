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
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var timeLeftView: TimeLeftView!
    @IBOutlet weak var socialMediaView: SocialMediaView!
    @IBOutlet weak var upcomingView: UpcomingEventView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Event.delegates.append(self)
        
        socialMediaView.delegate = self
        mentorView.slackButtonDelgate = self
        scrollView.contentSize = CGSizeMake(view.frame.size.width,
            115 * 2 + 150 + 120) // TODO: make this not static

    }
    
    override func setupConstraints() {
        socialMediaView.snp_makeConstraints { make in
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(44)
        }

        scrollView.snp_makeConstraints { make in
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.bottom.equalTo(socialMediaView.snp_top)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        topView.snp_makeConstraints { make in
            make.height.equalTo(115)
            make.top.equalTo(scrollView.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        mentorView.snp_makeConstraints { make in
            make.height.equalTo(115)

            make.centerX.equalTo(view.snp_centerX)
            
            make.left.equalTo(view.snp_left)
            make.top.equalTo(topView.snp_bottom)
        }

        timeLeftView.snp_makeConstraints { make in
            make.top.equalTo(mentorView.snp_bottom)
            make.height.equalTo(150)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        upcomingView.snp_makeConstraints { make in
            make.top.equalTo(timeLeftView.snp_bottom)
            make.height.equalTo(120)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

    }
}

extension DashboardViewController: SocialMediaViewDelegate, SlackButtonDelegate {
    func onTap(socialMedia: SocialMedia) {
        
        if #available(iOS 9, *) {
            let safari = SFSafariViewController(URL: socialMedia.url)
            self.presentViewController(safari, animated: true, completion: nil)
        } else {
            UIApplication.sharedApplication().openURL(socialMedia.url)
        }
        
    }
    func onTap(button: SlackButton) {
        
        // if it can open in slack app, open in slack app
        if UIApplication.sharedApplication().canOpenURL(LAHConstants.SlackURL) {
            UIApplication.sharedApplication().openURL(LAHConstants.SlackURL)
        } else {
            if #available(iOS 9, *) {
                let safari = SFSafariViewController(URL: NSURL(string: "https://losaltoshacks.slack.com/")!)
                self.presentViewController(safari, animated: true, completion: nil)
            } else {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://losaltoshacks.slack.com/")!)
            }
        }
    }
}

extension DashboardViewController: CacheableDelegate {
    func didUpdateCache() {
        upcomingView.awakeFromNib()
    }
}
