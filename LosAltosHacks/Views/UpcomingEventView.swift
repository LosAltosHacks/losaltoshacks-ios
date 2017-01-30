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
        let cell = fetchScheduleTableViewCell()

        latestEventView.addSubview(cell)
        latestEventCell = cell

        updateCell()

        super.awakeFromNib()
    }

    func updateCell() {
        guard let events = Event.cached(sort: true),
            let first = events.first else {
            isHidden = true
            return
        }
        isHidden = false

        if latestEventCell == nil {
            latestEventCell = fetchScheduleTableViewCell()
            latestEventView.addSubview(latestEventCell)
        }

        // gets the first event AFTER now, or the first if there are none after now
        let nextEvent = events.reduce(first) { latest, event in

            // if latest is before now, return the event
            if latest.time.isEarlierThanDate(Date()) {
                return event
            }

            // otherwise, return latest
            return latest
        }

        latestEventCell.event = nextEvent
    }

    func fetchScheduleTableViewCell() -> ScheduleTableViewCell {
        // /puke
        
        defer {
            // remove VC as much as possible
            scheduleVC.view = nil
            scheduleVC.tableView = nil
            scheduleVC.didReceiveMemoryWarning()
            scheduleVC.dismiss(animated: false, completion: nil)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let scheduleVC = storyboard.instantiateViewController(withIdentifier: "scheduleVC") as! ScheduleViewController
        
        if #available(iOS 9.0, *) {
            scheduleVC.loadViewIfNeeded()
        } else {
            scheduleVC.loadView()
        }
        
        let cell = scheduleVC.tableView.dequeueReusableCell(withIdentifier: ScheduleViewController.cellIdentifier) as! ScheduleTableViewCell
        cell.awakeFromNib()
        return cell
    }

    override func setupConstraints() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.height.equalTo(28)
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        latestEventView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        latestEventCell.snp.makeConstraints { make in
            // should always be at the top of the view
//            make.top.equalTo(latestEventView.snp.top).priority(.high)
            // make size "dynamic"
//            make.edges.equalTo(latestEventView.snp.edges).priority(.medium)
//            make.size.equalTo(latestEventView.snp.size).priority(.medium)
        }
    }
}
