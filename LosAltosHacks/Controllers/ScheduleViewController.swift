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

    //    var events = [Event]()
    var events: [EventParse]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)

        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension

        refreshControl.beginRefreshing()
        refresh()
    }

    func refresh() {
        //        Event.fetch({[weak self] in self?.refreshControl.endRefreshing()}) { events  in
        //            self.events = events
        //            self.tableView.reloadData()
        //            self.refreshControl.endRefreshing()
        //        }

        EventParse.fetch(sortBy: .Newest) { events, error in
            self.events = events as? [EventParse]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
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
        //        return events.count
        return events?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ScheduleViewController.cellIdentifier)! as! ScheduleTableViewCell

        if let events = events {
            let event = events[indexPath.row]
            cell.event = event
        }

        var date = NSDate()
        var timestamp = UInt64(floor(date.timeIntervalSince1970 * 1000))
        //if date <= event.to && date >= event.from {
        //we are in the time of the event
        //  cell.splotchView.backgroundColor = UIColor.greenColor()
        //  }
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        if events?.count <= 0 {

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
            label.textColor = LAHConstants.Color.DefaultGreyColor.value

            container.addSubview(label)

            tableView.backgroundView = container
            return 0
        }
        
        tableView.tableFooterView = nil
        tableView.backgroundView = nil
        
        return 1
    }
}
