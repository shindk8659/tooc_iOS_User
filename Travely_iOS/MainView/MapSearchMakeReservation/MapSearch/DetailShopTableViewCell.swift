//
//  DetailTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/24/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit
import ExpandableCell

class DetailShopTableViewCell: UITableViewCell {

    var simpleStoreInfo : SimpleStoreResponseDtos?
    @IBOutlet weak var storeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
