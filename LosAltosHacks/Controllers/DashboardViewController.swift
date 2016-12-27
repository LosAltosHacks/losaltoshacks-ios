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

        Event.delegates.append(WeakCacheableDelegate(self))

        socialMediaView.delegate = self
        mentorView.slackButtonDelgate = self
        scrollView.contentSize = CGSize(width: view.frame.size.width,
            height: 115 * 2 + 150 + 135) // TODO: make this not static
    }
    
    override func setupConstraints() {
        socialMediaView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(44)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(socialMediaView.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }

        topView.snp.makeConstraints { make in
            make.height.equalTo(115)
            make.top.equalTo(scrollView.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }

        mentorView.snp.makeConstraints { make in
            make.height.equalTo(115)

            make.centerX.equalTo(view.snp.centerX)
            
            make.left.equalTo(view.snp.left)
            make.top.equalTo(topView.snp.bottom)
        }

        timeLeftView.snp.makeConstraints { make in
            make.top.equalTo(mentorView.snp.bottom)
            make.height.equalTo(150)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }

        upcomingView.snp.makeConstraints { make in
            make.top.equalTo(timeLeftView.snp.bottom)
            make.height.equalTo(135)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
}

extension DashboardViewController: SocialMediaViewDelegate, SlackButtonDelegate {
    func openURL(_ url: URL) {
        if #available(iOS 9, *) {
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true, completion: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func onTap(_ socialMedia: SocialMedia) {
        openURL(socialMedia.url as URL)
    }
    func onTap(_ button: SlackButton) {
        openURL(URL(string: LAHConstants.SlackURLString)!)
    }
}

extension DashboardViewController: CacheableDelegate {
    func didUpdateCache() {
        upcomingView.updateCell()
    }
}
