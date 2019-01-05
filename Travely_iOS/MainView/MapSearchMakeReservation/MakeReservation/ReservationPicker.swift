//
//  ReservationPicker.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 24/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

protocol tossTheTime {
    func tossTheTime(checkDate: Date, findDate: Date, timeInterval: Int, dateSet: [String])
}

enum status: String {
    case check
    case find
}

class ReservationPicker: UIViewController {
    
    @IBOutlet var checkView: UIView!
    @IBOutlet var findView: UIView!
    @IBOutlet var intervalTime: UILabel!
    
    @IBOutlet var checkViewLabel: [UILabel]!
    
    @IBOutlet var findViewLabel: [UILabel]!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var addTimeButtons: [UIButton]!
    
    @IBAction func didPressHour(_ sender: Any) {
        self.date = Date(timeInterval: 3600, since: date)
    }
    
    @IBAction func didPressHourx4(_ sender: Any) {
        self.date = Date(timeInterval: 14400, since: date)
    }
    
    @IBAction func didPressHourx12(_ sender: Any) {
        self.date = Date(timeInterval: 43200, since: date)
    }
    
    @IBAction func didPressMinusHour(_ sender: Any) {
        switch status {
        case .check:
            if checkDate.addingTimeInterval(-3600) > datePicker.minimumDate! {
            self.date = Date.init(timeInterval: -3600, since: date)
            }
        case .find:
            if findDate.addingTimeInterval(-3660) >= checkDate{
                self.date = Date.init(timeInterval: -3600, since: date)
            }
        }
    }
    
    @IBAction func didPressConfirmation(_ sender: UIButton) {
        let dateSet: [String] = [checkViewLabel[1].text!, checkViewLabel[2].text!, findViewLabel[1].text!, findViewLabel[2].text!, intervalTime.text!]
        self.delegate.tossTheTime(checkDate: checkDate , findDate: findDate, timeInterval: timeInterval, dateSet: dateSet)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    var delegate: tossTheTime!
    var checkDate = Date()
    var findDate = Date()
    
    var initialCheck1: Bool = true
    var initialCheck2: Bool = true
    var timeInterval = 14400
    
    var status: status = .check {
        didSet {
            switch status {
            case .check:
                for label in checkViewLabel {
                    label.textColor = .white
                }
                checkView.backgroundColor = UIColor(red: 0x1F, green: 0xBF, blue: 0xC8)

                for label in findViewLabel {
                    label.textColor = UIColor(red: 0x49, green: 0x49, blue: 0x49)
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
                findView.backgroundColor = UIColor(red: 0x1F, green: 0xBF, blue: 0xC8)
                
                for label in checkViewLabel {
                    label.textColor = UIColor(red: 0x49, green: 0x49, blue: 0x49)
                }
                checkView.backgroundColor = .white
                
                datePicker.minimumDate = Date.init(timeInterval: 60, since: checkDate)
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
            let calendar = NSCalendar.current
            let dateComponents = calendar.dateComponents( [.year, .day, .hour, .minute], from: date)
            let fixedDate = calendar.date(from: dateComponents)
            
            datePicker.setDate(fixedDate!, animated: true)
            
            switch status {
            case .check:
                checkDate = fixedDate!
                
                if findDate <= date {
                    findDate = Date.init(timeInterval: 60, since: date)
                }
                
            case .find:
                findDate = fixedDate!
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
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "mm"
//        print(Int(dateFormatter.string(from: datePicker.date))!)
//
//        if Int(dateFormatter.string(from: datePicker.date))! % 15 != 0 {
//            let timeinterval = Double(Int(dateFormatter.string(from: datePicker.date))! % 15)
//            datePicker.date.addTimeInterval(900-timeinterval*60)
//        }
//        date = datePicker.date
    
        
        
//        date = Date(timeIntervalSinceNow: 0)
        status = .check
        changeLabel()
        
//        datePicker.backgroundColor = UIColor(displayP3Red: 76, green: 100, blue: 253, alpha: 0.5)
//        datePicker.isOpaque = false
//        datePicker.backgroundColor = UIColor(red: 76, green: 100, blue: 253, alpha: 1)
        //주석
    }
    
    func buttonLayerSetup() {
        for button in addTimeButtons {
            let color = UIColor(red: 0x70, green: 0x70, blue: 0x70)
            button.layer.borderWidth = 1
            button.layer.borderColor = color.cgColor
            button.setTitleColor(color, for: .normal)
//            button.layer.cornerRadius = button.frame.width / 2
            button.layer.masksToBounds = true
        }
    }
    
    func viewLayerSetup() {
        checkView.layer.borderWidth = 1
        checkView.layer.borderColor = UIColor(red: 0xCB, green: 0xCB, blue: 0xCB).cgColor
        checkView.layer.cornerRadius = 5
        findView.layer.cornerRadius = 5
        findView.layer.borderWidth = 1
        findView.layer.borderColor = UIColor(red: 0xCB, green: 0xCB, blue: 0xCB).cgColor
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
            checkViewLabel[2].text = dateFormatter2.string(from: date)
            
            findViewLabel[1].text = dateFormatter1.string(from: findDate)
            findViewLabel[2].text = dateFormatter2.string(from: findDate)
            
        case .find:
            findViewLabel[1].text = dateFormatter1.string(from: date)
            findViewLabel[2].text = dateFormatter2.string(from: date)
        }
        
        /*
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: checkDate)
        let date2 = calendar.startOfDay(for: findDate)
        let components = calendar.dateComponents([.hour, .minute], from: date1, to: date2)
        print(components, components.date, components.hour, components.minute)
        */
        
        let Interval = findDate.timeIntervalSince(checkDate)
        let t1 = Int(Interval) / 60
        timeInterval = Int(Interval)
//        if t1 >= 60 {
//           let t2 = t1 / 60
//           let t3 = t1 - t2*60
//            print("\(t2)시간 \(t3)분")
//        }
        
        if t1 >= 1440 {
            let t2 = t1 / 1440 // 일
            let t3 = t1 - t2*1440
            let t4 = t3 / 60 // 시간
            let t5 = t3 - t4*60 // 분
            intervalTime.text = "\(t2)일 \(t4)시간 \(t5)분"
        } else if t1 >= 60 {
            let t2 = t1 / 60
            let t3 = t1 - t2*60
            intervalTime.text = "\(t2)시간 \(t3)분"
        } else {
            intervalTime.text = ("\(t1)분")
        }
        
    }
}
