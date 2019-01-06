//
//  ReviewViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/5/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyReviewViewController: UIViewController ,ReloadViwDelegate{
    func reloadView() {
        self.getMyReview()
    }
    
    
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
        networkManager.getMyReview { [weak self](reviews, errorModel, error) in
            
            // 리뷰 
            if reviews == nil && errorModel == nil && error != nil {
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController,animated: true,completion: nil)
            }
            else if reviews == nil && errorModel != nil && error == nil {
                let alertController = UIAlertController(title: "",message: "정확한 정보를 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController,animated: true,completion: nil)
            }
            else {
                self?.myReviewModel = reviews
                self?.reviewCountLabel.text = "후기 \((reviews?.count)!)개"
                self?.reviewListTableView.reloadData()
               
            }
            
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
        cell.reviewStoreStarRatingView.rating = Double((self.myReviewModel?[indexPath.row]?.liked)!)
        return cell
    }
 
    
}
extension MyReviewViewController: UITableViewDelegate
{
    
}
extension MyReviewViewController: DeleteReviewReloadTableView
{
    func ModifyReview(onCell: MyReviewTableViewCell) {
        let indexPath = self.reviewListTableView.indexPath(for: onCell)
        let index :Int = gino(indexPath?.row)
        let modifyReview = UIStoryboard.init(name: "Alert", bundle: nil).instantiateViewController(withIdentifier: "makereview") as! MakeReviewPopupViewController
        modifyReview.delegate = self
        modifyReview.storeIdx = gino(self.myReviewModel?[index]?.storeIdx)
        modifyReview.content = gsno(self.myReviewModel?[index]?.content)
        modifyReview.liked = Double(gino(self.myReviewModel?[index]?.liked))
        self.present(modifyReview, animated: true, completion: nil)
        
    }
    
    func didDeleteReview(onCell: MyReviewTableViewCell) {
        getMyReview()
    }
}
