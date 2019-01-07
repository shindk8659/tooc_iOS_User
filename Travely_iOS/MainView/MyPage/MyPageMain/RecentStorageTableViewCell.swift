//
//  RecentStorageTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
protocol MakeReviewPresentView {
    func makeReview(onCell: RecentStorageTableViewCell)
}

class RecentStorageTableViewCell: UITableViewCell {

    @IBOutlet weak var recentStorageImg: UIImageView!
    @IBOutlet weak var recentStorageNameLabel: UILabel!
    @IBOutlet weak var recentStorageAddressLabel: UILabel!
    @IBOutlet weak var recentStorageTimeLabel: UILabel!
    @IBAction func makeReviewButtonAction(_ sender: Any) {
        self.delegate?.makeReview(onCell: self)
    }
    @IBAction func makeReserveButtonAction(_ sender: Any) {
    }
    var delegate: MakeReviewPresentView?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
