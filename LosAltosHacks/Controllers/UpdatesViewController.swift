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

//    var updates = [Update]()
    var updates: [UpdateParse]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension

        refreshControl.beginRefreshing()
        refresh()
    }
    
    func refresh() {
        UpdateParse.fetch { updates, error -> Void in
            if error != nil {
                print(error)
            } else if let updates = updates {
                self.updates = updates as? [UpdateParse]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()

                if updates.count > 0 {
                    self.tableView.backgroundView?.hidden = true
                }
            }
        }
//        Update.fetch({[weak self] in self?.refreshControl.endRefreshing()}) { updates in
//            self.updates = updates
//            self.tableView.reloadData()
//            self.refreshControl.endRefreshing()
//        }
    }
    
    override func setupConstraints() {
        tableView.snp_makeConstraints { make in
            make.margins.equalTo(view.snp_margins).priorityMedium()
            make.topMargin.equalTo(view.snp_topMargin).offset(9).priorityHigh()
//            make.bottomMargin.equalTo(snp_bottomLayoutGuideTop).offset(-9).priorityHigh()
        }
    }
}

extension UpdatesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UpdatesViewController.cellIdentifier)! as! UpdateTableViewCell

        if let updates = updates {
            let update = updates[indexPath.row]

            cell.descriptionLabel.text = update.content
            cell.dateLabel.text = LAHPreferredDisplay.from(update.createdAt!)
            cell.iconView.image = UIImage(named: update.tag)
            cell.splotchView.backgroundColor = LAHConstants.Color(from: update.tag)!.value
        }

//        cell.descriptionLabel.text = update.description
//        cell.dateLabel.text = LAHPreferredDisplay.from(update.date)
//        cell.iconView.image = UIImage(named: update.tag)
//        cell.splotchView.backgroundColor = LAHConstants.Color(from: update.tag)!.value

        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if updates?.count <= 0 {
            let container = UIView(frame: CGRectMake(0, 0, 200, 200))

            container.center = tableView.center

            let image = UIImageView(image: UIImage(named: "empty")!)

            image.contentMode = .ScaleAspectFill
            image.frame = CGRectMake(0, 0, 60, 60)
            image.center = CGPointMake(container.center.x, container.center.y - 30)
            
            container.addSubview(image)

            let label = UILabel(frame: CGRectMake(0, 0, 200, 44))

            label.center = CGPointMake(container.center.x, container.center.y + 30)
            label.text = "Check back later for updates."
            label.numberOfLines = 0
            label.textAlignment = .Center
            label.font = UIFont.systemFontOfSize(18)
            label.textColor = LAHConstants.Color.DefaultGreyColor.value

            container.addSubview(label)

            tableView.backgroundView = container
            return 0
        }
        return 1
    }
}
