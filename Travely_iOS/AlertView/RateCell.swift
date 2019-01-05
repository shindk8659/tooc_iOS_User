//
//  RateCell.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 06/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class RateCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
