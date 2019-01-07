//
//  ReservationViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 28/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class ReservationViewController: UITableViewController {
    
    //이전뷰에서 가져온 데이터들
    var closeTime:Int = 0
    var currentBag:Int = 0
    var limit:Int = 0
    var opentime:Int = 0
    var week:Int = 0
    var restWeekResponseDtos:[RestWeekResponseDtos?]?
    
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
    var serviceRate: [Int] = [4, 6, 8, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120]
    
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
    
    @IBOutlet var suitCaseStepper: CSStepper!
    
    @IBOutlet var luggageStepper: CSStepper!
    
    @IBOutlet var totalRateLabel: UILabel!
    
    @IBAction func didPressFareInfo(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ServiceRateAlertViewController") as! ServiceRateAlertViewController
        tabBarController?.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func didPressBagSizeInfo(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BagSizeAlertViewController") as! BagSizeAlertViewController
        tabBarController?.present(vc, animated: false, completion: nil)
    }
    
    
    @IBAction func didPressType(_ sender: UIButton) {
        if sender.tag == 0 {
            if suitcaseCheck == false {
                suitcaseCheck = !suitcaseCheck
                sender.setImage(UIImage(named: "checkbox_fill"), for: .normal)
                numberOfSuitcase = 1
                suitCaseStepper.value = 1
                tableView.reloadData()
            } else {
                suitcaseCheck = !suitcaseCheck
                sender.setImage(UIImage(named: "checkbox_empty"), for: .normal)
                numberOfSuitcase = 0
                rateOfSuitcase = 0
                totalRate = rateOfSuitcase + rateOfLuggage
                totalRateLabel.text = "\(totalRate)원"
                tableView.reloadData()
            }
        } else {
            if luggageCheck == false {
                luggageCheck = !luggageCheck
                sender.setImage(UIImage(named: "checkbox_fill"), for: .normal)
                numberOfLuggage = 1
                luggageStepper.value = 1
                tableView.reloadData()
            } else {
                luggageCheck = !luggageCheck
                sender.setImage(UIImage(named: "checkbox_empty"), for: .normal)
                numberOfLuggage = 0
                rateOfLuggage = 0
                totalRate = rateOfSuitcase + rateOfLuggage
                totalRateLabel.text = "\(totalRate)원"
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func didPressSCStepper(_ sender: CSStepper) {
        numberOfSuitcase = sender.value
        rateOfSuitcase = rate*Int(numberOfSuitcase)
        totalRate = rateOfSuitcase + rateOfLuggage
        numberOfSuitcaseLabel.text = "\(numberOfSuitcase)개 \(String(rateOfSuitcase))원"
        totalRateLabel.text = "\(totalRate)원"
    }
    
    @IBAction func didPressLGStepper(_ sender: CSStepper) {
        numberOfLuggage = sender.value
        rateOfLuggage = rate*Int(numberOfLuggage)
        totalRate = rateOfSuitcase + rateOfLuggage
        numberOfLuggageLabel.text = "\(numberOfLuggage)개 \(String(rateOfLuggage))원"
        totalRateLabel.text = "\(totalRate)원"
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
        let storeIdx = gino(restWeekResponseDtos?[0]?.storeIdx)
        let startTime = Int(checkTime.timeIntervalSince1970)*1000
        let endTime = Int(findTime.timeIntervalSince1970)*1000
        var bagDtos:[[String : Any]] = []
        
        
        if numberOfSuitcase != 0 {
            let suitCase: [String : Any] = ["bagType" : "CARRIER", "bagCount" : numberOfSuitcase]
            bagDtos.append(suitCase)
        }
        
        if numberOfLuggage != 0 {
            let luggage: [String : Any] = ["bagType" : "ETC", "bagCount" : numberOfLuggage]
            bagDtos.append(luggage)
        }

       networkManager.saveReservation(storeIdx:storeIdx , startTime: startTime, endTime: endTime, bagDtos: bagDtos, payType: payment) { [weak self] (data, errorModel, error) in

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
                print("통신 성공")
                print(data)
                let storyboard = UIStoryboard(name: "Alert", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ReservationAlertViewController") as! ReservationAlertViewController
                vc.type = .reserve
                vc.delegate = self
                self!.tabBarController?.present(vc, animated: false, completion: nil)
            } 
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //테스트프린트
        print("테스트프린트",closeTime,currentBag,limit,opentime,restWeekResponseDtos!,week)
        suitcaseCheck = false
        luggageCheck = false
        reservationButton.isEnabled = false
        reservationButton.backgroundColor = .darkGray
        layoutSetup()
        
        self.addBackButton("white")
        self.navigationItem.title = "예약하기"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 31, green: 191, blue: 200)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 31, green: 191, blue: 200)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        networkManager.bringPriceList { [weak self] (result, errorModel, error) in
            if result == nil && errorModel == nil && error != nil {
                print(errorModel, error)
            }
                // 서버측 에러핸들러 구성후 바꿔야함
            else if result == nil && errorModel != nil && error == nil {
                print(errorModel, error)
            }
            else {
                print("통신 성공")
                print(result)
            }
        }
    }
    
    @objc func didPressCAFView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationPicker") as! ReservationPicker
        
        var dayOffArray: [Int]? = [Int]()
        for dayOff in restWeekResponseDtos! {
            if dayOff?.week != nil {
                dayOffArray?.append((dayOff?.week)!)
            }
        }
        
        vc.delegate = self
        vc.checkDate = checkTime
        vc.findDate = findTime
        vc.openTime = Date(timeIntervalSince1970: Double(opentime/1000))
        vc.closeTime = Date(timeIntervalSince1970: Double(closeTime/1000))
        vc.dayOff = dayOffArray
        tabBarController?.present(vc, animated: false, completion: nil)
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
        let ReservationStatusViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReservationStatusNavi")
        
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
        calculatebasicRate(interval: timeInterval)
    }
    
    func calculatebasicRate(interval: Int) {
        
        // 서버 로직(알고리즘)
        var hour = interval / 60 / 60
        if hour * 60 * 60 != interval {
            print("실행")
            hour += 1
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        for rate in serviceRate {
//            if rate == serviceRate.last {
//                serviceRate.append(rate + 12)
//                print(serviceRate.last, rate)
//            }
            
            if interval <= rate*3600 {
                switch rate {
                case 4: self.rate = 3500
                basicRate.text = "4시간 기본 요금: 3500원"
                case 6: self.rate = 4500
                basicRate.text = "4~6시간 기본 요금: 4500원"
                case 8: self.rate = 5500
                basicRate.text = "6~8시간 기본 요금: 5500원"
                case 12: self.rate = 6500
                basicRate.text = "8~12시간 기본 요금: 6500원"
                case 24: self.rate = 7500
                basicRate.text = "12~24시간 기본 요금: 6500원"
                default: self.rate = 7500 + 4000*(rate - 24)/12
                basicRate.text = "\(rate-12)~\(rate)시간 기본 요금: \(self.rate)원"
                }
                rateOfSuitcase = self.rate*Int(numberOfSuitcase)
                rateOfLuggage = self.rate*Int(numberOfLuggage)
                totalRate = rateOfSuitcase + rateOfLuggage
                numberOfSuitcaseLabel.text = "\(numberOfSuitcase)개 \(String(rateOfSuitcase))원"
                numberOfLuggageLabel.text = "\(numberOfLuggage)개 \(String(rateOfLuggage))원"
                totalRateLabel.text = "\(totalRate)원"
                return
            }
        }
        //4시간, 4~6, 6~8, 8~12, 12~24, 24~36, 36~48 ... 12시간 단위
    }
}

