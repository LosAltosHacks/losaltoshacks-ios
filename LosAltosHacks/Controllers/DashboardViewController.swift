//
//  DashboardViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit
import SnapKit

class DashboardViewController: BaseViewController {

    @IBOutlet weak var mentorView: MentorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var timeLeftView: UIView!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!

    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,
            selector: "tick:", userInfo: nil, repeats: true)
    }

    func tick(timer: NSTimer) {

        let endDate = NSDate.specificDate(1, day: 31, year: 2016, hour: 18)
//        print(NSDate.stringFromTimeInterval(endDate.timeIntervalSinceNow))
        let timeLeft = endDate.timeIntervalSinceNow
        countdownLabel.text = "\(timeLeft.hourString):\(timeLeft.minuteString)"
//        let timeToFinish =
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupConstraints() {
        
        mentorView.snp_makeConstraints { make in
            make.height.equalTo(view.snp_height)
                .dividedBy(5)
            
            make.centerX.equalTo(view.snp_centerX)
            
            make.leading.equalTo(view.snp_leading)
            make.top.equalTo(snp_topLayoutGuideBottom)
        }

        scrollView.snp_makeConstraints { make in
            make.top.equalTo(mentorView.snp_bottom)
            make.bottom.equalTo(snp_bottomLayoutGuideBottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        timeLeftView.snp_makeConstraints { make in
            make.top.equalTo(scrollView.snp_top)
            make.height.equalTo(200)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }

        timeRemainingLabel.snp_makeConstraints { make in
            make.top.equalTo(20)
            make.centerX.equalTo(timeLeftView.snp_centerX)
        }

        countdownLabel.snp_makeConstraints { make in
            make.top.equalTo(timeRemainingLabel.snp_bottomMargin)
            make.centerX.equalTo(timeLeftView.snp_centerX)
            make.width.equalTo(240)
            make.height.equalTo(96)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
