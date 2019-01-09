//
//  ServiceTermOfServiceViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/9/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class ServiceTermOfServiceViewController: UIViewController {
    @IBOutlet weak var contentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTableView.delegate = self
        contentTableView.dataSource = self
        self.addBackButton("black")
    }
    
    
    
    
}
extension ServiceTermOfServiceViewController: UITableViewDelegate
{
    
}
extension ServiceTermOfServiceViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicetermcell") as! ServiceTermOfServiceTableViewCell
        return cell
    }
    
    
}

