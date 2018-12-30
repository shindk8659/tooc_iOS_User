//
//  ReservationViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 28/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class ReservationViewController: UITableViewController {
    
    
    let numberOfLuggageArray: [String] = ["   1","   2","   3","   4","   5","   6","   7"]
    var suitcaseCheck: Bool!
    var luggageCheck: Bool!
    var numberOfSuitcase = 0
    var numberOfLuggage = 0
    
    @IBOutlet var dateAndTimeView: [UIView]!
    
    @IBOutlet var amountView: [UIView]!
    
    
    @IBOutlet var reservationButton: UIButton!
    
    @IBOutlet var suitcasePicker: UIPickerView!
    
    @IBOutlet var luggagePicker: UIPickerView!
    
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
        suitcasePicker.delegate = self
        suitcasePicker.dataSource = self
        luggagePicker.delegate = self
        luggagePicker.dataSource = self
        layoutSetup()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 && suitcaseCheck == false {
            return 0
        }
        
        if indexPath.row == 3 && luggageCheck == false {
            return 0
        }
        
        if indexPath.row == 4 && (suitcaseCheck == true || luggageCheck == true) {
            return 68
        } else if indexPath.row == 4 {
            return 0
        }
        
        return UITableView.automaticDimension
    }
    
    func layoutSetup() {
        for view in dateAndTimeView {
            view.layer.cornerRadius = 8
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.black.cgColor
        }
        
        for view in amountView {
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.black.cgColor
        }
        
        reservationButton.layer.cornerRadius = reservationButton.frame.width / 13
    }
}

extension ReservationViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfLuggageArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberOfLuggageArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
            pickerLabel?.textAlignment = .left
        }
        pickerLabel?.text = numberOfLuggageArray[row]
        pickerLabel?.textColor = UIColor.darkGray
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 픽커뷰 셀렉트
    }
    
}
