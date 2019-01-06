//
//  MyReviewTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/5/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import Cosmos

protocol DeleteReviewReloadTableView {
    func didDeleteReview(onCell: MyReviewTableViewCell)
    func ModifyReview(onCell: MyReviewTableViewCell)
}
class MyReviewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var reviewStoreNameLabel: UILabel!
    @IBOutlet weak var reviewStoreAddressLabel: UILabel!
    @IBOutlet weak var reviewImg: UIImageView!
    @IBOutlet weak var reviewStoreTimeLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var reviewStoreStarRatingView: CosmosView!
    
    var delegate: DeleteReviewReloadTableView?
    let networkManager = NetworkManager()
    var reviewIdx:Int?
    
    
    @IBAction func reviewModifyAction(_ sender: Any) {
        self.delegate?.ModifyReview(onCell: self)
        
        
    }
    @IBAction func reviewDeleteAction(_ sender: Any) {
        self.networkManager.deleteReview(reviewIdx: reviewIdx!) { [weak self](delete, errModel, err) in
            self?.delegate?.didDeleteReview(onCell: self!)
          
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var frame = self.reviewTextView.frame
        frame.size.height = self.reviewTextView.contentSize.height
        self.reviewTextView.frame = frame
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
