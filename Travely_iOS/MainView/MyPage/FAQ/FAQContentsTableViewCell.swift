//
//  FAQContentsTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/10/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class FAQContentsTableViewCell: UITableViewCell {

    @IBOutlet weak var faqContentsTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        var frame = self.faqContentsTextView.frame
        frame.size.height = self.faqContentsTextView.contentSize.height
        self.faqContentsTextView.frame = frame
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
