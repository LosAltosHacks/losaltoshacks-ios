//
//  UpdatesViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit
import SnapKit

class UpdatesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    static let cellIdentifier = "updateCell"
    
    var updates = [Update]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tableView.dataSource = self
        
        fetchUpdates()
    }

    override func setupConstraints() {
        tableView.snp_makeConstraints { make in
            make.margins.equalTo(view.snp_margins).priorityMedium()
            make.topMargin.equalTo(view.snp_topMargin).offset(9).priorityHigh()
        }
    }
    
    func fetchUpdates() {

        // fetch updates (this is temporary)
        self.updates = [Update(date: NSDate(), description: "Nothing yet...")]
        
        self.tableView.reloadData()
    }

}

extension UpdatesViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UpdatesViewController.cellIdentifier)! as! UpdateTableViewCell
        
        let update = updates[indexPath.row]

        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let date = formatter.stringFromDate(update.date)
        
        cell.descriptionLabel.text = update.description
        cell.dateLabel.text = date
        
        
        return cell
    }
}
