//
//  ReservationViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 28/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class ReservationViewController: UITableViewController {
    
    var suitcaseCheck: Bool!
    var luggageCheck: Bool!
    var numberOfSuitcase = 0
    var numberOfLuggage = 0
    
    @IBOutlet var checkAndFindView: UIView!
    @IBOutlet var dateAndTimeView: [UIView]!
    
    @IBOutlet var reservationButton: UIButton!
    
    @IBOutlet var kakaoPay: UIButton!
    @IBOutlet var cash: UIButton!
    
    @IBOutlet var numberOfSuitcaseLabel: UILabel!
    @IBOutlet var numberOfLuggageLabel: UILabel!
    
    @IBOutlet var luggageChoiceLabel: UILabel!
    
    
    
    @IBAction func didPressType(_ sender: UIButton) {
        if sender.tag == 0 {
            if suitcaseCheck == false {
                suitcaseCheck = !suitcaseCheck
                sender.setImage(UIImage(named: "checkbox_fill"), for: .normal)
                
                tableView.reloadData()
            } else {
                suitcaseCheck = !suitcaseCheck
                sender.setImage(UIImage(named: "checkbox_empty"), for: .normal)
                
                tableView.reloadData()
            }
        } else {
            if luggageCheck == false {
                luggageCheck = !luggageCheck
                sender.setImage(UIImage(named: "checkbox_fill"), for: .normal)
                
                tableView.reloadData()
            } else {
                luggageCheck = !luggageCheck
                sender.setImage(UIImage(named: "checkbox_empty"), for: .normal)
                
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func didPressPayment(_ sender: UIButton) {
           let fill = UIImage(named: "bt_circle_fill")
           let empty = UIImage(named: "bt_circle_empty")
        if sender.tag == 1 {
            cash.setImage(fill, for: .normal)
            kakaoPay.setImage(empty, for: .normal)
        }else {
            kakaoPay.setImage(fill, for: .normal)
            cash.setImage(empty, for: .normal)
        }
    }
    
    @IBAction func didPressAgreement(_ sender: UIButton) {
        if sender.tag == 0 {
        sender.setImage(UIImage(named: "bt_circle_fill_small"), for: .normal)
        sender.tag += 1
        } else {
        sender.setImage(UIImage(named: "bt_circle_empty"), for: .normal)
        sender.tag -= 1 
        }
    }
    
    @IBAction func didPressReservation(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suitcaseCheck = false
        luggageCheck = false
        layoutSetup()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didPressCAFView))
        self.checkAndFindView.addGestureRecognizer(tap)
    }
    
    @objc func didPressCAFView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationPicker") as! ReservationPicker
        self.present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 3 && suitcaseCheck == false {
            return 0
        }

        if indexPath.row == 5 && luggageCheck == false {
            return 0
        }
        
        //주석
//        if indexPath.row == 4 && (suitcaseCheck == true || luggageCheck == true) {
//            return 68
//        } else if indexPath.row == 4 {
//            return 0
//        }
        
        return UITableView.automaticDimension
    }
    
    func layoutSetup() {
        for view in dateAndTimeView {
            view.layer.cornerRadius = 8
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.black.cgColor
        }
        
        reservationButton.layer.cornerRadius = reservationButton.frame.width / 13
    }
}

