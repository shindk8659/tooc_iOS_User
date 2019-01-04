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
            print(favoriteStore)
            print(errorModel)
        }
    }

}

extension FavoriteStoreViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteregioncell") as! FavoriteRegionTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell.separatorInset = UIEdgeInsets.zero
            return cell
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoritestorecell") as! FavoriteStoreTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell.separatorInset = UIEdgeInsets.zero
            return cell
            
        }
    }
    
}
extension FavoriteStoreViewController: UITableViewDelegate
{
    
}
