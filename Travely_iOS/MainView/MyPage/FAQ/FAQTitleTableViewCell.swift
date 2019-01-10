//
//  FAQTitleTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/10/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import ExpandableCell

class FAQTitleTableViewCell: ExpandableCell {

    @IBOutlet weak var faqTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
