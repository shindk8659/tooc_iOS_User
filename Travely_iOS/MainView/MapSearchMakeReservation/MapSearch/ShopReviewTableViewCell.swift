//
//  ShopReviewTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/26/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class ShopReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var userGradeLabel: UILabel!
    @IBOutlet weak var userReviewTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        var frame = self.userReviewTextView.frame
        frame.size.height = self.userReviewTextView.contentSize.height
        self.userReviewTextView.frame = frame
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
