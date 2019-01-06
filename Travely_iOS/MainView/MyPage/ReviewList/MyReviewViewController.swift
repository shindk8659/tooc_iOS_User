//
//  ReviewViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/5/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyReviewViewController: UIViewController {
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var reviewListTableView: UITableView!
    let networkManager = NetworkManager()
    var myReviewModel: [MyReviewModel?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reviewListTableView.delegate = self
        self.reviewListTableView.dataSource = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.addBackButton("black")
        self.getMyReview()
            
        
    }
    func getMyReview()
    {
        networkManager.getMyReview { [weak self](reviews, errormodel, error) in
            self?.myReviewModel = reviews
            self?.reviewCountLabel.text = "후기 \((reviews?.count)!)개"
            self?.reviewListTableView.reloadData()
            
        }
        
    }
  


}
extension MyReviewViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gino(self.myReviewModel?.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myreviewcell") as! MyReviewTableViewCell
        var frame = cell.frame
        frame.size.height = cell.contentView.frame.height
        cell.delegate = self
        cell.frame = frame
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        cell.separatorInset = UIEdgeInsets.zero
        cell.reviewIdx = self.myReviewModel?[indexPath.row]?.reviewIdx
        cell.reviewStoreNameLabel.text = self.myReviewModel?[indexPath.row]?.storeName
        cell.reviewStoreAddressLabel.text = self.myReviewModel?[indexPath.row]?.address
        cell.reviewImg.imageFromUrl(self.myReviewModel?[indexPath.row]?.storeImgUrl)
        cell.reviewTextView.text = self.myReviewModel?[indexPath.row]?.content
        return cell
    }
 
    
}
extension MyReviewViewController: UITableViewDelegate
{
    
}
extension MyReviewViewController: DeleteReviewReloadTableView
{
    func didDeleteReview(onCell: MyReviewTableViewCell) {
        print("델리게이트")
        getMyReview()
    }
}
