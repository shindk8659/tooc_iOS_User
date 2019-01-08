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
        self.addBackButton("white")
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
    func setStoreTime(openTime: Int?, closeTime: Int?) -> String{
        if openTime != nil && closeTime != nil {
            
            // 개장시간과 폐장시간을 timeStemp 로 받아 Date객체로 변환
            let openTimestamp = gino(openTime)/1000
            let closeTemestamp = gino(closeTime)/1000
            let openDate = Date(timeIntervalSince1970: Double(gino(openTimestamp)))
            let closeDate = Date(timeIntervalSince1970: Double(gino(closeTemestamp)))
            
            // Date객체에서 가져올 포맷과 시간대를 정하고 String 으로 꺼내서 반환 함
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+9") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
            let open = dateFormatter.string(from: openDate)
            let close = dateFormatter.string(from: closeDate)
            let wholeTime = "매일 \(open) ~ \(close)"
            return wholeTime
        }
        else {
            return ""
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
        let time = setStoreTime(openTime: gino(self.myReviewModel?[indexPath.row]?.openTime), closeTime: gino(self.myReviewModel?[indexPath.row]?.closeTime))
        cell.reviewStoreTimeLabel.text = time
        return cell
    }
 
    
}
extension MyReviewViewController: UITableViewDelegate
{
    
}
extension MyReviewViewController: ReviewReloadTableView
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
