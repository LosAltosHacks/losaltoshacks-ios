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
    var events = [Event]()
    var estimatedHeights = [Int:CGFloat]()
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
        Event.getEvents() { events in
            //            self.updates = updates
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}



extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ScheduleViewController.cellIdentifier)! as! ScheduleTableViewCell
        
        let event = events[indexPath.row]
        
        cell.descriptionLabel.text = event.description
        cell.dateLabel.text = LAHPreferredDisplay.range(event.from, dateTo: event.to)
        //cell.iconView.image = UIImage(named: event.tag)
        //cell.splotchView.backgroundColor = LAHConstants.LAHFunnyColors[event.tag]
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if events.count <= 0 {
            let container = UIView(frame: CGRectMake(0, 0, 200, 200))
            
            container.center = tableView.center
            
            let image = UIImageView(image: UIImage(named: "empty")!)
            
            image.contentMode = .ScaleAspectFill
            image.frame = CGRectMake(0, 0, 60, 60)
            image.center = CGPointMake(container.center.x, container.center.y - 30)
            
            container.addSubview(image)
            
            let label = UILabel(frame: CGRectMake(0, 0, 200, 44))
            
            label.center = CGPointMake(container.center.x, container.center.y + 30)
            label.text = "Check back later for upcoming events."
            label.numberOfLines = 0
            label.textAlignment = .Center
            label.font = UIFont.systemFontOfSize(18)
            label.textColor = LAHConstants.defaultGreyColor
            
            container.addSubview(label)
            
            tableView.backgroundView = container
            return 0
        }
        return 1
    }
}
