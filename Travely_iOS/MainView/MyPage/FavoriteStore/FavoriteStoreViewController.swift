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
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell.separatorInset = UIEdgeInsets.zero
            cell.favoriteStoreNameLabel.text = gsno(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].storeName)
            cell.favoriteStoreImg.imageFromUrl(gsno(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].storeImgUrl))
            cell.favoriteStoreAddressLabel.text = gsno(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].address)
            cell.starRateView.rating = (self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].grade)!
            //cell.favoriteStoreTimeLabel.text = gsno(self.favoriteModel?[indexPath.section]?.simpleStoreResponseDtos?[indexPath.row - 1].)
            return cell
            
        }
    }
    
}
extension FavoriteStoreViewController: UITableViewDelegate
{
    
}
