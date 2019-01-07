//
//  ShopAdressTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/26/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class ShopAddressTableViewCell: UITableViewCell {
    
    var storeIdx:Int?
    var openDate:Date?
    var closeDate:Date?
    @IBOutlet weak var shopAddressLabel: UILabel!
    @IBOutlet weak var shopOldAddressLabel: UILabel!
    @IBOutlet weak var openCloseImageView: UIImageView!
    @IBOutlet weak var shopTimeLabel: UILabel!
    @IBOutlet weak var shopWebsiteLabel: UILabel!
    @IBOutlet weak var shopCallNumLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    let networkManager = NetworkManager()
    
    @IBAction func likeStoreButtonAction(_ sender: Any) {
        
        networkManager.setFavorite(storeIdx: storeIdx!) { [weak self](setFavorite, errorModel, error) in
           
            if setFavorite == nil && errorModel == nil && error != nil {
                
            }
               
            else if setFavorite == nil && errorModel != nil && error == nil {
                
            }
            else {
                if  setFavorite?.isFavorite == -1 {
                    self?.favoriteButton.imageView?.image = UIImage(named: "ic_favorite_gray.png")
                    
                }
                else {
                    self?.favoriteButton.imageView?.image = UIImage(named: "icFavoriteColor.png")
                    
                }
                
            }
            
        }
    }
    @IBAction func findPathButtonAction(_ sender: Any) {
        
        let url :URL = URL(string: "daummaps://route?sp=37.537229,127.005515&ep=37.4979502,127.0276368&by=PUBLICTRANSIT")!
        if (UIApplication.shared.canOpenURL(url)) {
             UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        else {
             let url :URL = URL(string: "https://itunes.apple.com/us/app/id304608425?mt=8")!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
       
       
        
        
    }
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
