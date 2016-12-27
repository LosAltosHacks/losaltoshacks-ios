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

        refreshControl.addTarget(self, action: #selector(UpdatesViewController.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)

        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension

        if updates.isEmpty {
//            refreshControl.beginRefreshing()
            refresh()
        }
    }

    func refresh() {
        Update.fetch(error: {[weak self] in self?.refreshControl.endRefreshing()}) { [weak self] updates in
            self?.updates = updates
            self?.tableView?.reloadData()
            self?.refreshControl.endRefreshing()
            
            Update.store(updates)
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

extension UpdatesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UpdatesViewController.cellIdentifier)! as! UpdateTableViewCell
        
        let update = updates[indexPath.row]
        
        cell.update = update
        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        if updates.count <= 0 {
            
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
        
        tableView.backgroundView = nil
        
        return 1
    }
}
