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
    func makeReservation(storeIdx:Int,closeTime:Int,currentBag:Int,limit:Int,opentime:Int,available:Int,
    restWeekResponseDtos:[RestWeekResponseDtos?]?)
    
}

class RecentStorageTableViewCell: UITableViewCell {
    //이전뷰에서 가져온 데이터들
    var storeIdx:Int = 0
    var closeTime:Int = 0
    var currentBag:Int = 0
    var limit:Int = 0
    var opentime:Int = 0
    var available:Int = 0
    var restWeekResponseDtos:[RestWeekResponseDtos?]?

    @IBOutlet weak var recentStorageImg: UIImageView!
    @IBOutlet weak var recentStorageNameLabel: UILabel!
    @IBOutlet weak var recentStorageAddressLabel: UILabel!
    @IBOutlet weak var recentStorageTimeLabel: UILabel!
    @IBAction func makeReviewButtonAction(_ sender: Any) {
        self.delegate?.makeReview(onCell: self)
    }
    @IBAction func makeReserveButtonAction(_ sender: Any) {
        self.delegate?.makeReservation(storeIdx: storeIdx, closeTime: closeTime, currentBag: currentBag, limit: limit, opentime: opentime, available:available,restWeekResponseDtos: restWeekResponseDtos)
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
