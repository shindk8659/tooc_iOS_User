//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class FavoriteStoreViewController: UIViewController {

    let networkModel = NetworkManager()
    var favoriteModel: [FavoriteModel?]?
    @IBOutlet weak var favoriteStoreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoriteStoreTableView.delegate = self
        self.favoriteStoreTableView.dataSource = self
       
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.addBackButton("black")
        networkModel.getFavoriteStore { [weak self](favoriteStore, errorModel, error) in
            
            // 리뷰
            if favoriteStore == nil && errorModel == nil && error != nil {
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController,animated: true,completion: nil)
            }
            else if favoriteStore == nil && errorModel != nil && error == nil {
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController,animated: true,completion: nil)
            }
            else {
                
                self?.favoriteModel = favoriteStore
                self?.favoriteStoreTableView.reloadData()
                
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

extension FavoriteStoreViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        print(gino(self.favoriteModel?.count))
        return gino(self.favoriteModel?.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(gino(self.favoriteModel?[section]?.simpleStoreResponseDtos?.count))
        return gino(self.favoriteModel?[section]?.simpleStoreResponseDtos?.count) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteregioncell") as! FavoriteRegionTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell.separatorInset = UIEdgeInsets.zero
            cell.regionNameLabel.text = gsno(self.favoriteModel?[indexPath.section]?.regionName) + "(\(gino(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?.count)))"
            
            return cell
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoritestorecell") as! FavoriteStoreTableViewCell
            cell.delegate = self
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell.separatorInset = UIEdgeInsets.zero
            cell.storeIdx = self.gino(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].storeIdx)
            cell.closeTime = self.gino(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].closeTime)
            cell.currentBag  = self.gino(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].currentBag)
            cell.limit = self.gino(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].limit)
            cell.opentime = self.gino(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].openTime)
            cell.restWeekResponseDtos = self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].restWeekResponseDtos
            cell.favoriteStoreNameLabel.text = gsno(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].storeName)
            cell.favoriteStoreImg.imageFromUrl(gsno(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].storeImgUrl))
            cell.favoriteStoreAddressLabel.text = gsno(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].address)
            cell.starRateView.rating = (self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].grade)!
            let time = setStoreTime(openTime: gino(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].openTime), closeTime: gino(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].closeTime))
            cell.favoriteStoreTimeLabel.text = time
            //cell.favoriteStoreTimeLabel.text = gsno(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].)
            return cell
            
        }
    }
    
}
extension FavoriteStoreViewController: UITableViewDelegate
{
    
}
extension FavoriteStoreViewController: MakeReviewPresentView
{
    func makeReview(onCell: RecentStorageTableViewCell) {
        
    }
    
    func makeReservation(storeIdx: Int, closeTime: Int, currentBag: Int, limit: Int, opentime: Int, restWeekResponseDtos: [RestWeekResponseDtos?]?) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationViewController") as! ReservationViewController
        vc.closeTime = closeTime
        vc.currentBag = currentBag
        vc.limit = limit
        vc.opentime = opentime
        vc.restWeekResponseDtos = restWeekResponseDtos
        vc.storeIdx = storeIdx
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
