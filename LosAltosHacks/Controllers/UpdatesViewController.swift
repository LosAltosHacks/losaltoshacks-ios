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
    
    let refreshControl = UIRefreshControl()
    
    var updates = [Update]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        refresh()
    }
    
    func refresh() {
        Update.getUpdates() { updates in
            self.updates = updates
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func setupConstraints() {
        tableView.snp_makeConstraints { make in
            make.margins.equalTo(view.snp_margins).priorityMedium()
            make.topMargin.equalTo(view.snp_topMargin).offset(9).priorityHigh()
        }
    }
}

extension UpdatesViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UpdatesViewController.cellIdentifier)! as! UpdateTableViewCell
        
        let update = updates[indexPath.row]
        
        cell.descriptionLabel.text = update.description
        cell.dateLabel.text = update.date.LAHPreferredDisplay
        
        return cell
    }
}
