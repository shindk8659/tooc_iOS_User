//
//  FavoriteStoreTableViewCell.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/5/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import Cosmos

class FavoriteStoreTableViewCell: UITableViewCell {

    var delegate: MakeReviewPresentView?
    
    //이전뷰에서 가져온 데이터들
    var storeIdx:Int = 0
    var closeTime:Int = 0
    var currentBag:Int = 0
    var limit:Int = 0
    var opentime:Int = 0
    var available:Int = 0
    var restWeekResponseDtos:[RestWeekResponseDtos?]? = nil
    
    @IBOutlet weak var starRateView: CosmosView!
    @IBOutlet weak var favoriteStoreImg: UIImageView!
    @IBOutlet weak var favoriteStoreNameLabel: UILabel!
    @IBOutlet weak var favoriteStoreAddressLabel: UILabel!
    @IBOutlet weak var favoriteStoreTimeLabel: UILabel!
   
    @IBAction func makeReservationButtonAction(_ sender: Any) {
        
        self.delegate?.makeReservation(storeIdx: storeIdx, closeTime: closeTime, currentBag: currentBag, limit: limit, opentime: opentime, available:available,restWeekResponseDtos: restWeekResponseDtos)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
