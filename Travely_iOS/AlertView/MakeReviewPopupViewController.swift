//
//  MakeReviewPopupViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/6/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import Cosmos
import UITextView_Placeholder
protocol ReloadViwDelegate {
    func reloadView()
}
class MakeReviewPopupViewController: UIViewController {

    let networkManager = NetworkManager()
    var storeIdx:Int = 0
    var content:String = ""
    var liked:Double = 0.0
    var delegate: ReloadViwDelegate?
    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var reviewAlertView: UIView!
    @IBOutlet weak var reviewContenTextView: UITextView!
    @IBOutlet weak var starRatingView: CosmosView!
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendReviewButtonAction(_ sender: Any) {
        networkManager.makeReview(storeIdx: storeIdx, content: reviewContenTextView.text, liked: Int(starRatingView.rating)) {[weak self] (review, errorModel, err) in
            self?.delegate?.reloadView()
          self?.dismiss(animated: true, completion: nil)
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        reviewAlertView.layer.cornerRadius = 6
        if content == "" {
             reviewContenTextView.placeholder = "내용을 입력해주세요. 상세하게 적을수록 다른 고객에게 큰 도움이 됩니다."
        }
        else {
            reviewTitle.text = "리뷰수정"
             reviewContenTextView.text = content
        }
        if liked != 0.0 {
            starRatingView.rating = liked
        }
        
       starRatingView.settings.fillMode = .full
    }


}

