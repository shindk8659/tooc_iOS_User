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
class MakeReviewPopupViewController: UIViewController {

    @IBOutlet weak var reviewAlertView: UIView!
    @IBOutlet weak var reviewContenTextView: UITextView!
    @IBOutlet weak var starRatingView: CosmosView!
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendReviewButtonAction(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reviewAlertView.layer.cornerRadius = 6
        reviewContenTextView.placeholder = "내용을 입력해주세요. 상세하게 적을수록 다른 고객에게 큰 도움이 됩니다."
       
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

