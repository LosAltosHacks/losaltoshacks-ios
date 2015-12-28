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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupConstraints() {
        
        // Mentor View
        mentorView.snp_makeConstraints { make in
            make.height.equalTo(view.snp_height)
                .dividedBy(5)
            
            make.centerX.equalTo(view.snp_centerX)
            
            make.leading.equalTo(view.snp_leading)
            make.top.equalTo(snp_topLayoutGuideBottom)
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
