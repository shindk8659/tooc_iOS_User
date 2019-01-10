//
//  WholeTermTableViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/9/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class WholeTermTableViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
         self.addBackButton("black")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
}
