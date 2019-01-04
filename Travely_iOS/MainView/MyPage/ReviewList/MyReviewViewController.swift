//
//  ReviewViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/5/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyReviewViewController: UIViewController {

    @IBOutlet weak var reviewListTableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reviewListTableView.delegate = self
        self.reviewListTableView.dataSource = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
  


}
extension MyReviewViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myreviewcell") as! MyReviewTableViewCell
        var frame = cell.frame
        frame.size.height = cell.contentView.frame.height
        cell.frame = frame
        return cell
    }
 
    
}
extension MyReviewViewController: UITableViewDelegate
{
    
}
