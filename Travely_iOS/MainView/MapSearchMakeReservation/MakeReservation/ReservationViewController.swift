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
    var payment = "CARD"
    var checkTime = Date()
    var findTime = Date()
    
    var rate = 3500
    var rateOfSuitcase = 0
    var rateOfLuggage = 0
    var totalRate = 0
    
    let networkManager = NetworkManager()
    var reservationDetail: ReservationModel?
    
    @IBOutlet var checkAndFindView: UIView!
    @IBOutlet var dateAndTimeView: [UIView]!
    
    @IBOutlet var checkLabel: [UILabel]!
    @IBOutlet var findLabel: [UILabel]!
    @IBOutlet var basicRate: UILabel!
    @IBOutlet var totalTime: UILabel!
    
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
                numberOfSuitcase = 1
                tableView.reloadData()
            } else {
                suitcaseCheck = !suitcaseCheck
                sender.setImage(UIImage(named: "checkbox_empty"), for: .normal)
                numberOfSuitcase = 0
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
    
    @IBAction func didPressSCStepper(_ sender: CSStepper) {
        sender.value = numberOfSuitcase
        print(numberOfSuitcase)
    }
    
    
    @IBAction func didPressPayment(_ sender: UIButton) {
           let fill = UIImage(named: "bt_circle_fill")
           let empty = UIImage(named: "bt_circle_empty")
        if sender.tag == 1 {
            cash.setImage(fill, for: .normal)
            kakaoPay.setImage(empty, for: .normal)
            payment = "CASH"
        }else {
            kakaoPay.setImage(fill, for: .normal)
            cash.setImage(empty, for: .normal)
            payment = "CARD"
        }
    }
    
    @IBAction func didPressAgreement(_ sender: UIButton) {
        if sender.tag == 0 {
        sender.setImage(UIImage(named: "bt_circle_check_small"), for: .normal)
        sender.tag += 1
        reservationButton.isEnabled = true
        reservationButton.backgroundColor = UIColor(red: 0x1F, green: 0xBF, blue: 0xC8)
        } else {
        sender.setImage(UIImage(named: "bt_circle_empty"), for: .normal)
        sender.tag -= 1
        reservationButton.isEnabled = false
        reservationButton.backgroundColor = .darkGray
        }
    }
    
    @IBAction func didPressReservation(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationAlertViewController") as! ReservationAlertViewController
//        vc.delegate = self
//        self.present(vc, animated: true, completion: nil)
        let startTime = Int(checkTime.timeIntervalSince1970)
        let endTime = Int(findTime.timeIntervalSince1970)
        let testbag1:[[String : Any]] = [["bagType" : "CARRIER", "bagCount" : 2]]
        
//        let testbag2 = Bag(bagType: "CARRIER", bagCount: 2)
//        let jsonData = try? JSONEncoder().encode(testbag2)
//        let json = String(data: jsonData!, encoding: String.Encoding.utf16)
        
        networkManager.saveReservation(storeIdx: 2, startTime: startTime, endTime: endTime, bagDtos: testbag1, payType: payment) { [weak self] (data, errorModel, error) in
            if data == nil && errorModel == nil && error != nil {
                print(errorModel, error)
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController, animated: true, completion: nil)
            }
                // 서버측 에러핸들러 구성후 바꿔야함
            else if data == nil && errorModel != nil && error == nil {
                print(errorModel, error)
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController, animated: true, completion: nil)
            }
            else {
//                let storyboard = UIStoryboard(name: "Alert", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "ReservationAlertViewController") as! ReservationAlertViewController
//                vc.delegate = self
//                self?.present(vc, animated: true, completion: nil)
                print("통신 성공")
                print(data)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suitcaseCheck = false
        luggageCheck = false
        reservationButton.isEnabled = false
        reservationButton.backgroundColor = .darkGray
        layoutSetup()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didPressCAFView))
        self.checkAndFindView.addGestureRecognizer(tap)
        
        self.tabBarController?.hideTabBarAnimated(hide: false)
        
        checkTime = Date(timeIntervalSinceNow: 0)
        findTime = Date(timeIntervalSinceNow: 14400)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier:"ko_KR")
        dateFormatter1.dateFormat = "MM월dd일 (E)"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH : mm"
        
        checkLabel[0].text = dateFormatter1.string(from: checkTime)
        checkLabel[1].text = dateFormatter2.string(from: checkTime)
        
        findLabel[0].text = dateFormatter1.string(from: findTime)
        findLabel[1].text = dateFormatter2.string(from: findTime)
    }
    
    @objc func didPressCAFView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationPicker") as! ReservationPicker
        vc.delegate = self
        vc.checkDate = checkTime
        vc.findDate = findTime
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
            view.layer.borderColor = UIColor(red: 0xCB, green: 0xCB, blue: 0xCB).cgColor
        }
        
        reservationButton.layer.cornerRadius = reservationButton.frame.width / 13
    }
    
}

extension ReservationViewController: changeTabProtocol,tossTheTime {

    func changeTabViewController() {
        let ReservationStatusViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReservationStatusViewController") as! ReservationStatusViewController
        
        ReservationStatusViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_reservation_gray_tab"),tag: 1)
        
        ReservationStatusViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.tabBarController?.viewControllers![1] = ReservationStatusViewController
        self.tabBarController?.selectedIndex = 1
    }
    
    func tossTheTime(checkDate: Date, findDate: Date, timeInterval: Int, dateSet: [String]) {
        checkTime = checkDate
        findTime = findDate
        checkLabel[0].text = dateSet[0]
        checkLabel[1].text = dateSet[1]
        findLabel[0].text = dateSet[2]
        findLabel[1].text = dateSet[3]
        totalTime.text = dateSet[4]
    }
    
//    func calculatebasicRate(interval: TimeInterval) {
//        print(interval)
//        //4시간, 4~6, 6~8, 8~12, 12~24, 24~36, 36~48 ... 12시간 단위
//    }
}

