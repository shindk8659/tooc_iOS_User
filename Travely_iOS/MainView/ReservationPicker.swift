//
//  ReservationPicker.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 24/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

enum status: String {
    case check
    case find
}


class ReservationPicker: UIViewController {
    
    @IBOutlet var checkView: UIView!
    @IBOutlet var findView: UIView!
    
    @IBOutlet var checkViewLabel: [UILabel]!
    
    @IBOutlet var findViewLabel: [UILabel]!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var addTimeButtons: [UIButton]!
    
    @IBAction func didPressHour(_ sender: Any) {
        self.date = Date(timeInterval: 3600, since: date)
    }
    
    @IBAction func didPressThirty(_ sender: Any) {
        self.date = Date(timeInterval: 1800, since: date)
    }
    
    @IBAction func didPressfifteen(_ sender: Any) {
        self.date = Date(timeInterval: 900, since: date)
    }
    
    @IBAction func didPressMinusThirty(_ sender: Any) {
        switch status {
        case .check:
            if checkDate.addingTimeInterval(-1800) > datePicker.minimumDate! {
            self.date = Date.init(timeInterval: -1800, since: date)
            }
        case .find:
            if findDate.addingTimeInterval(-2700) >= checkDate{
                self.date = Date.init(timeInterval: -1800, since: date)
            }
        }
    }
    
    @IBAction func didPressConfirmation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var checkDate = Date()
    var findDate = Date()
    
    var initialCheck1: Bool = true
    var initialCheck2: Bool = true
    
    var status: status = .check {
        didSet {
            switch status {
            case .check:
                for label in checkViewLabel {
                    label.textColor = .white
                }
                checkView.backgroundColor = .lightGray
                
                for label in findViewLabel {
                    label.textColor = .lightGray
                }
                findView.backgroundColor = .white
                
                datePicker.minimumDate = Date.init(timeIntervalSinceNow: 0)
                guard initialCheck1 == true else {
                    datePicker.date = checkDate
                    return
                }
                initialCheck1 = false
                
            case .find:
                for label in findViewLabel {
                    label.textColor = .white
                }
                findView.backgroundColor = .lightGray
                
                for label in checkViewLabel {
                    label.textColor = .lightGray
                }
                checkView.backgroundColor = .white
                
                datePicker.minimumDate = Date.init(timeInterval: 900, since: checkDate)
                guard initialCheck2 == true else {
                    datePicker.date = findDate
                    return
                }
                initialCheck2 = false
            }
        }
    }
    
    var date: Date = Date() {
        didSet {
            datePicker.setDate(date, animated: true)
            
            switch status {
            case .check:
                checkDate = date
                
                if findDate <= date {
                    findDate = Date.init(timeInterval: 900, since: date)
                }
                
            case .find:
                findDate = date
            }
            changeLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(check))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(find))
        self.checkView.addGestureRecognizer(tap1)
        self.findView.addGestureRecognizer(tap2)
        
        buttonLayerSetup()
        viewLayerSetup()
        pickerSetup()
    }
    
    @objc func valueChanged() {
        if datePicker.date <= datePicker.minimumDate! {
            datePicker.setDate(date, animated: false)
        } else {
        date = datePicker.date
        }
    }
    
    @objc func check() {
        status = .check
        date = checkDate
    }
    
    @objc func find() {
        status = .find
        date = findDate
    }
    
    func pickerSetup() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        print(Int(dateFormatter.string(from: datePicker.date))!)
        
        if Int(dateFormatter.string(from: datePicker.date))! % 15 != 0 {
            let timeinterval = Double(Int(dateFormatter.string(from: datePicker.date))! % 15)
            datePicker.date.addTimeInterval(900-timeinterval*60)
        }
        date = datePicker.date
        status = .check
        findDate = date.addingTimeInterval(900)
        
//        datePicker.backgroundColor = UIColor(displayP3Red: 76, green: 100, blue: 253, alpha: 0.5)
//        datePicker.isOpaque = false
//        datePicker.backgroundColor = UIColor(red: 76, green: 100, blue: 253, alpha: 1)
    }
    
    func buttonLayerSetup() {
        for button in addTimeButtons {
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.layer.cornerRadius = button.frame.width / 2
            button.layer.masksToBounds = true
            
            button.clipsToBounds = true
            button.layoutIfNeeded()
        }
    }
    
    func viewLayerSetup() {
        checkView.layer.borderWidth = 0.5
        checkView.layer.borderColor = UIColor.black.cgColor
        checkView.layer.cornerRadius = 5
        findView.layer.cornerRadius = 5
        findView.layer.borderWidth = 0.5
        findView.layer.borderColor = UIColor.black.cgColor
        checkView.layer.masksToBounds = true
        findView.layer.masksToBounds = true
    }
    
    func changeLabel() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier:"ko_KR")
        dateFormatter1.dateFormat = "MM월dd일 (E)"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH : mm"
        
        switch status {
        case .check:
            checkViewLabel[1].text = dateFormatter1.string(from: date)
            checkViewLabel[3].text = dateFormatter2.string(from: date)
            
            findViewLabel[1].text = dateFormatter1.string(from: findDate)
            findViewLabel[3].text = dateFormatter2.string(from: findDate)
            
        case .find:
            findViewLabel[1].text = dateFormatter1.string(from: date)
            findViewLabel[3].text = dateFormatter2.string(from: date)
        }
    }
}
