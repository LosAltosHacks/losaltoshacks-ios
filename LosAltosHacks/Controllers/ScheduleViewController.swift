//
//  ScheduleViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit

class ScheduleViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    static let cellIdentifier = "scheduleCell"

    let refreshControl = UIRefreshControl()

    var events = Event.cached(sort: true) ?? []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)

        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension

        if events.isEmpty {
            refreshControl.beginRefreshing()
            refresh()
        }
    }

    func refresh() {
        Event.fetch(error: {[weak self] in self?.refreshControl.endRefreshing()}) { [weak self] events  in
            self?.events = events
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            
            // update cache
            Event.store(events)
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

extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return events.onSaturday.count
        case 1:
            return events.onSunday.count
        default:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ScheduleViewController.cellIdentifier)! as! ScheduleTableViewCell

        let index = indexPath.row
        let event: Event
        switch indexPath.section {
        case 0:
            event = events.onSaturday[index]
        case 1:
            event = events.onSunday[index]
        default:
            event = events[index]
        }
        
        cell.event = event
        
        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String
        switch(section) {
        case 0: // Saturday
            header = "SATURDAY"
        case 1: // Sunday
            header = "SUNDAY"
        default:
            header = "DAY"
        }
        return header
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if events.count <= 0 {

            tableView.tableFooterView = UIView()

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
        
        tableView.tableFooterView = nil
        tableView.backgroundView = nil
        
        return 2 // 2 day event
    }
}
