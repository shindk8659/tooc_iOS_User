//
//  ReservationAlertViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 29/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

protocol changeTabProtocol {
    func changeTabViewController()
}

enum type: String {
    case reserve
    case cancel
}

class ReservationAlertViewController: UIViewController {
    
    var delegate: changeTabProtocol!
    var type: type?
    
    @IBOutlet var alertView: UIView!
    @IBOutlet var confirmButton: UIButton!
    
    @IBOutlet var reservationLabel: UILabel!
    
    @IBAction func didPressConfirm(_ sender: UIButton) {
        if type == .reserve {
        self.dismiss(animated: true) {
            self.delegate!.changeTabViewController()
        }
        } else {
            self.dismiss(animated: true) {
                self.delegate!.changeTabViewController()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        
        if type == .reserve {
            reservationLabel.text = "예약이 완료되었습니다.     예약 내역을 확인해주세요."
        } else {
            reservationLabel.text = "예약이 취소되었습니다."
        }
    }
    
    func layoutSetup() {
        alertView.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 18
    }
}
