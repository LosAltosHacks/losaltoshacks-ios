//
//  UpcomingEventView.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/11/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class UpcomingEventView: BaseView {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var latestEventView: UIView!
    var latestEventCell: ScheduleTableViewCell!

    override func awakeFromNib() {
        
        guard let events = Event.cached(sort: true),
            first = events.first else {
            // cache is empty
            self.hidden = true // hide just in case
            return
        }
        
        // awakeFromNib might be called programatically (from DashboardViewController)
        self.hidden = false
        
        // gets the first event AFTER now, or the first if there are none after now
        let nextEvent = events.reduce(first) { latest, event in
            
            // if latest is before now, return the event
            if latest.start.isEarlierThanDate(NSDate()) {
                return event
            }
            
            // otherwise, return latest
            return latest
        }
        
        let cell = fetchScheduleTableViewCell()
        
        cell.event = nextEvent
        latestEventView.addSubview(cell)
        latestEventCell = cell
        
        super.awakeFromNib()
    }
    
    func fetchScheduleTableViewCell() -> ScheduleTableViewCell {
        // /puke
        
        defer {
            // remove VC as much as possible
            scheduleVC.view = nil
            scheduleVC.tableView = nil
            scheduleVC.didReceiveMemoryWarning()
            scheduleVC.dismissViewControllerAnimated(false, completion: nil)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let scheduleVC = storyboard.instantiateViewControllerWithIdentifier("scheduleVC") as! ScheduleViewController
        
        if #available(iOS 9.0, *) {
            scheduleVC.loadViewIfNeeded()
        } else {
            scheduleVC.loadView()
        }
        
        return scheduleVC.tableView.dequeueReusableCellWithIdentifier(ScheduleViewController.cellIdentifier) as! ScheduleTableViewCell
    }

    override func setupConstraints() {
        sectionLabel.snp_makeConstraints { make in
            make.top.equalTo(self.snp_top)
            make.height.equalTo(28)
            make.centerX.equalTo(self.snp_centerX)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
        }
        
        latestEventView.snp_makeConstraints { make in
            make.top.equalTo(sectionLabel.snp_bottom).offset(10)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(self.snp_bottom)
        }
        
        latestEventCell.snp_makeConstraints { make in
            if latestEventCell.descriptionLabel?.text == "" {
                make.height.equalTo(80).priorityHigh()
            }
            // should always be at the top of the view
            make.top.equalTo(latestEventView.snp_top).priorityHigh()
            
            // make size "dynamic"
            make.edges.equalTo(latestEventView.snp_edges).priorityMedium()
            make.size.equalTo(latestEventView.snp_size).priorityMedium()
        }
    }
}
