//
//  FavoriteStoreTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/5/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class FavoriteStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteStoreImg: UIImageView!
    @IBOutlet weak var favoriteStoreNameLabel: UILabel!
    @IBOutlet weak var favoriteStoreAddressLabel: UILabel!
    @IBOutlet weak var favoriteStoreTimeLabel: UILabel!
   
    @IBAction func makeReservationButtonAction(_ sender: Any) {
        
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
