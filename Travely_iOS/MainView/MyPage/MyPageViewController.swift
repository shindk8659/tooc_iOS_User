//
//  MyPageViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var myPageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPageTableView.delegate = self
        self.myPageTableView.dataSource = self
        
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }
  

}
extension MyPageViewController: UITableViewDelegate
{
    
}
extension MyPageViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentstoragecell") as! RecentStorageTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    
}
