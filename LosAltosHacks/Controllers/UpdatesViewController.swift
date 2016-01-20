//
//  UpdatesViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit

class UpdatesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    static let cellIdentifier = "updateCell"

    let refreshControl = UIRefreshControl()
    
    var updates = Update.cached(sort: true) ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self

        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)

        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension

        if updates.isEmpty {
            refreshControl.beginRefreshing()
            refresh()
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("refreshUpdates", object: nil, queue: NSOperationQueue.mainQueue()) { [weak self] _ in
            
            self?.refreshControl.beginRefreshing()
            
            // update cache, on error try again (behind the scenes retries 6 times)
            Update.updateCache(sort: true, error: { Update.updateCache(error: {print("Failed fetching updates for cache")})}) { [weak self] updates in
                self?.updates = updates
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }

    func refresh() {
        Update.fetch(error: {[weak self] in self?.refreshControl.endRefreshing()}) { [weak self] updates in
            self?.updates = updates
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            
            Update.store(updates)
        }
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
        return updates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UpdatesViewController.cellIdentifier)! as! UpdateTableViewCell
        
        let update = updates[indexPath.row]
        
        cell.update = update
        
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if updates.count <= 0 {
            
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
            label.textColor = LAHColor.DefaultGreyColor.value
            
            container.addSubview(label)
            
            tableView.backgroundView = container
            return 0
        }
        
        tableView.backgroundView = nil
        
        return 1
    }
}
