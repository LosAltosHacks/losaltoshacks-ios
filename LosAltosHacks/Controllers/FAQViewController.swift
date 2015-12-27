//
//  FAQViewController.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

    static let CELL_IDENTIFIER = "FAQCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slackButton: UIButton!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

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