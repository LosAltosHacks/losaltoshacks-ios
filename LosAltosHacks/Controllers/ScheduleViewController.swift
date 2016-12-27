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

        refreshControl.addTarget(self, action: #selector(ScheduleViewController.refresh), for: UIControlEvents.valueChanged)
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
            self?.tableView?.reloadData()
            self?.refreshControl.endRefreshing()
            
            // update cache
            Event.store(events)
        }
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.margins.equalTo(view.snp.margins).priority(.medium)
            make.topMargin.equalTo(view.snp.topMargin).offset(9).priority(.high)
//            make.bottomMargin.equalTo(snp.bottomLayoutGuideTop).offset(-9).priority(.high)
        }
    }
}

extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return events.onSaturday.count
        case 1:
            return events.onSunday.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleViewController.cellIdentifier)! as! ScheduleTableViewCell

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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if events.count <= 0 {

            tableView.tableFooterView = UIView()

            let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

            container.center = tableView.center

            let image = UIImageView(image: UIImage(named: "empty")!)

            image.contentMode = .scaleAspectFill
            image.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            image.center = CGPoint(x: container.center.x, y: container.center.y - 30)

            container.addSubview(image)

            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))

            label.center = CGPoint(x: container.center.x, y: container.center.y + 30)
            label.text = "Check back later for updates."
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = LAHColor.defaultGreyColor.value

            container.addSubview(label)

            tableView.backgroundView = container
            return 0
        }
        
        tableView.tableFooterView = nil
        tableView.backgroundView = nil
        
        return 2 // 2 day event
    }
}
