//
//  FAQViewController.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit
import SnapKit

struct FAQ {
    var question: String
    var answer: String
}

class FAQViewController: UIViewController {

    static let CELL_IDENTIFIER = "FAQCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slackButton: UIButton!
    @IBOutlet weak var helpLabel: UILabel!

    @IBOutlet weak var mentorView: UIView!
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        
        // View Styles

        slackButton.layer.cornerRadius = 20
        slackButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        slackButton.layer.borderWidth = 1.0

        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension

        // Delegates

        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func setupConstraints() {
        
        // Mentor View
        mentorView.snp_makeConstraints { make in
            make.height.equalTo(128)
            make.centerX.equalTo(view.snp_centerX)

            make.leading.equalTo(view.snp_leading)
            make.top.equalTo(snp_topLayoutGuideBottom)
        }
        
        helpLabel.snp_makeConstraints { make in
            make.width.equalTo(267)
            make.height.equalTo(21)
            
            make.centerX.equalTo(mentorView.snp_centerX)
            make.top.equalTo(mentorView.snp_top).offset(24)
        }
        
        slackButton.snp_makeConstraints { make in
            make.width.equalTo(279)
            make.height.equalTo(44)
            
            make.centerX.equalTo(helpLabel.snp_centerX)
            make.top.equalTo(helpLabel.snp_bottom).offset(16)
        }
        
        
        // Table view
        tableView.snp_makeConstraints { make in
            make.top.equalTo(mentorView.snp_bottom)
            
            make.width.equalTo(view.snp_width)
            
            // uhh
            make.bottomMargin.equalTo(view.snp_bottomMargin).offset(-57)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: UITableViewDelegate

extension FAQViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(FAQViewController.CELL_IDENTIFIER) as! FAQTableViewCell

        cell.questionLabel.text = "WHAT IS LOS ALTOS HACKS?"
        cell.answerLabel.text = "Los Altos Hacks is the first ever hackathon to be in Los Altos."
        + " A hackathon is an event where people can code a project together. At Los Altos Hacks, "
        + "you will have 24 hours to make your idea a reality."

        return cell
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}