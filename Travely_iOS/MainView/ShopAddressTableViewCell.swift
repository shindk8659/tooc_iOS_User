//
//  ShopAdressTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/26/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class ShopAddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shopAddressLabel: UILabel!
    @IBOutlet weak var shopOldAddressLabel: UILabel!
    @IBOutlet weak var openCloseImageView: UIImageView!
    @IBOutlet weak var shopTimeLabel: UILabel!
    @IBOutlet weak var shopWebsiteLabel: UILabel!
    @IBOutlet weak var shopCallNumLabel: UILabel!
    
    @IBAction func likeStoreButtonAction(_ sender: Any) {
    }
    @IBAction func findPathButtonAction(_ sender: Any) {
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
