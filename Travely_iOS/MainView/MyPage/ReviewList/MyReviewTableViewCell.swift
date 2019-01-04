//
//  MyReviewTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/5/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewTableView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var frame = self.reviewTableView.frame
        frame.size.height = self.reviewTableView.contentSize.height
        self.reviewTableView.frame = frame
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
