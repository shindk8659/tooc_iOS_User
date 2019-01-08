//
//  ServiceRateAlertViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 06/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class ServiceRateAlertViewController: UIViewController {
    
    let timeArray = ["4(기본이용)", "4~6", "6~8", "8~12", "12~24", "24~36", "36~48"]
    var rateArray = [Int]()

    @IBOutlet var rateTableView: UITableView!
    
    @IBAction func didPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateTableView.delegate = self
        rateTableView.dataSource = self
        rateTableView.layer.cornerRadius = 8
    }

}

extension ServiceRateAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicRateCell") as! RateCell
        
        cell.timeLabel.text = timeArray[indexPath.row]
        if indexPath.row == 7 {
            cell.rateLabel.text = String(rateArray[0])
        } else {
        cell.rateLabel.text = String(rateArray[indexPath.row+1])
        }
        return cell
    }
}
