//
//  ReservationStatusViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 01/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import GoogleMaps

class ReservationStatusViewController: UITableViewController {
    
    @IBOutlet var halfBgImage: UIImageView!
    @IBOutlet var reservationView: UIView!
    @IBOutlet var qrCodeView: UIView!
    @IBOutlet var statusProgressView: [UIView]!
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var superViewOfMap: UIView!
    @IBOutlet var qrCode: UIImageView!
    @IBOutlet var reservationCode: UILabel!
    
    @IBOutlet var checkDate: UILabel!
    @IBOutlet var checkTime: UILabel!
    
    @IBOutlet var findDate: UILabel!
    @IBOutlet var findTime: UILabel!
    
    @IBOutlet var suitcaseRate: UILabel!
    @IBOutlet var luggageRate: UILabel!
    
    @IBOutlet var totalTime: UILabel!
    @IBOutlet var totalRate: UILabel!
    
    @IBOutlet var paymentProgress: UIImageView!
    
    @IBOutlet var payType: UILabel!
    @IBOutlet var totalRateOfPayment: UILabel!
    @IBOutlet var totalBag: UILabel!
    
    @IBOutlet var bagImages: [UIImageView]!
    
    @IBOutlet var storeName: UILabel!
    @IBOutlet var isOpenImg: UIImageView!
    @IBOutlet var openTime: UILabel!
    @IBOutlet var storeAdress: UILabel!
    
    @IBAction func didPressRVCancel(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "cancelConfirmViewController") as! cancelConfirmViewController
        vc.delegate = self
        self.tabBarController?.present(vc, animated: true, completion: nil)
    }
    
    let titleImageView = UIImageView.init(image: UIImage.init(named: "logoWhite.png"))
    lazy var mapView = GMSMapView()
    // mapMarker
    let marker = GMSMarker()
    var initialCheck = 1
    let networkManager = NetworkManager()
    var latitude:  CLLocationDegrees?
    var longitude:  CLLocationDegrees?
    var paymentState: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = titleImageView
        layoutSetup()
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            network()
            totalTime.text = UserDefaults.standard.string(forKey: "totalTime")
        
    }
    
    func network() {
        networkManager.bringReservationInfo { [weak self] (result, errorModel, error) in
            if result == nil && errorModel == nil && error != nil {
                print(errorModel, error)
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController, animated: true, completion: nil)
                print("error1")
            }
                // 서버측 에러핸들러 구성후 바꿔야함
            else if result == nil && errorModel != nil && error == nil {
                let DoNotRVNaviViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DoNotRVNavi")
                DoNotRVNaviViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_reservation_gray_tab"),tag: 1)
                DoNotRVNaviViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
                self!.tabBarController?.viewControllers![1] = DoNotRVNaviViewController
                self!.tabBarController?.selectedIndex = 1
            }
            else {
                print(result)
//                let storeIdx = gino(restWeekResponseDtos?[0]?.storeIdx)
                self!.paymentState = result?.stateType
                switch self!.paymentState {
                case "RESERVED":
                    self!.statusProgressView[0].backgroundColor = .white
                case "PAYED":
                    self!.statusProgressView[0].backgroundColor = .white
                    self!.statusProgressView[1].backgroundColor = .white
                case "ARCHIVE":
                    self!.statusProgressView[0].backgroundColor = .white
                    self!.statusProgressView[1].backgroundColor = .white
                    self!.statusProgressView[2].backgroundColor = .white
                case "PICKUP":
                    self!.statusProgressView[0].backgroundColor = .white
                    self!.statusProgressView[1].backgroundColor = .white
                    self!.statusProgressView[2].backgroundColor = .white
                    self!.statusProgressView[3].backgroundColor = .white
                case "CANCEL":
                    break
                default: break
                }
                
                self!.reservationCode.text = result?.reserveCode
                
                let image = self!.generateQRCode(from: self!.reservationCode.text!)
                self!.qrCode.image = image
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yy년 M월 d일 E요일"
                dateFormatter1.locale = Locale(identifier:"ko_KR")
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "a h시 m분"
                dateFormatter2.locale = Locale(identifier:"ko_KR")
                
                self!.checkDate.text = dateFormatter1.string(from: Date(timeIntervalSince1970: TimeInterval((result?.startTime)!/1000)))
                self!.checkTime.text = dateFormatter2.string(from: Date(timeIntervalSince1970: TimeInterval((result?.startTime)!/1000)))
                
                self!.findDate.text = dateFormatter1.string(from: Date(timeIntervalSince1970: TimeInterval((result?.endTime)!/1000)))
                self!.findTime.text = dateFormatter2.string(from: Date(timeIntervalSince1970: TimeInterval((result?.endTime)!/1000)))
                
//                if result?.bagDtos!.count == 1 {
//                    if result?.bagDtos![0]["bagType"] == "CARRIER" {
//                        let count = result?.bagDtos![0]["bagCount"]
//                        suitcaseRate.text = "\(count)개: \(result?.price)원"
//                    }
//                } else {
//
//                }
                
                switch result?.progressType {
                case "DONE": self!.paymentProgress.image = UIImage(named: "reserve_pay_rect")
                default: break
                }
                
                switch result?.payType {
                case "CASH": self!.payType.text = "현장 결제"
                case "CARD": self!.payType.text = "카카오 페이"
                default: break
                }
                
                let totalPrice = result!.price ?? 0
                self!.totalRateOfPayment.text = "\(totalPrice)원"
                self?.storeName.text = result?.store?.storeName
                self?.storeAdress.text = result?.store?.address
                print("클로즈 타임: \(result?.store?.closeTime)")
                
                self?.latitude = result?.store?.latitude
                self?.longitude = result?.store?.longitude
                
                let bagDtos = result?.bagDtos
                let unitPrice = result?.priceUnit ?? 0
                var totalCount = 0
                
                for bag in bagDtos! {
                    switch bag.bagType {
                    case "CARRIER" :
                        totalCount += bag.bagCount!
                        self!.suitcaseRate.text = "\(bag.bagCount ?? 0)개 \(unitPrice)원"
                    case "ETC" :
                        totalCount += bag.bagCount!
                        self!.luggageRate.text = "\(bag.bagCount ?? 0)개 \(unitPrice)원"
                    default: break
                    }
                }
                
                self?.totalRate.text = "요금: \(unitPrice)원 X \(totalCount)개"
            
            }
        }
    }

    func layoutSetup() {
        halfBgImage.layer.shadowColor = UIColor.black.cgColor
        halfBgImage.layer.shadowRadius = 5
        halfBgImage.layer.shadowOpacity = 0.5
        halfBgImage.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        reservationView.layer.cornerRadius = 20
        reservationView.layer.shadowColor = UIColor.black.cgColor
        reservationView.layer.shadowRadius = 10
        reservationView.layer.shadowOpacity = 0.5
        reservationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        qrCodeView.layer.shadowColor = UIColor.black.cgColor
        qrCodeView.layer.shadowRadius = 5
        qrCodeView.layer.shadowOpacity = 0.5
        qrCodeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        for view in statusProgressView {
            view.layer.borderWidth = 2
            //        view.layer.borderColor = UIColor(displayP3Red: 166, green: 174, blue: 234, alpha: 1).cgColor
            view.layer.borderColor = UIColor(red: 0xA9, green: 0xD2, blue: 0xD5).cgColor
            view.layer.cornerRadius = view.frame.width / 2
        }
        
        cancelButton.layer.borderWidth = 0.5
        cancelButton.layer.borderColor = UIColor(red: 0xB6, green: 0xB6, blue: 0xB6).cgColor
        cancelButton.layer.cornerRadius = cancelButton.frame.width / 13
        
        mapView.isMyLocationEnabled = true
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    override func viewDidLayoutSubviews() {
        
        if let lat = latitude, let long = longitude {
        if initialCheck == 1 {
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: superViewOfMap.frame.width, height: superViewOfMap.frame.height), camera: GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15))
            mapView.settings.setAllGesturesEnabled(false)
        superViewOfMap.addSubview(mapView)
            initialCheck += 1
            
            //지도 마커
            marker.icon = UIImage(named: "icPinColor.png")
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.map = self.mapView
            mapView.camera = GMSCameraPosition.camera(withTarget: self.marker.position, zoom: 16)
        }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        switch paymentState {
        case "RESERVED":
            if indexPath.row == 3 {
                return 0
            }
        case "PAYED":
            if indexPath.row == 2 || indexPath.row == 3  {
                return 0
            }
        case "ARCHIVE":
            if indexPath.row == 2 {
                return 0
            }
        case "PICKUP":
            if indexPath.row == 2 {
                return 0
            }
        default: break
        }
        return UITableView.automaticDimension
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 820 + ((820*self.view.frame.width)/375 - 820)
//        case 1:
//            return 210 + ((210*self.view.frame.width)/375 - 210)
//        case 2:
//            return 350 + ((350*self.view.frame.width)/375 - 350)
//        default: return 0
//        }
//    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReservationStatusViewController: presentAlert, changeTabProtocol {
    func changeTabViewController() {
        let DoNotRVNaviController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DoNotRVNavi")
        
        DoNotRVNaviController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_reservation_gray_tab"),tag: 1)
        
        DoNotRVNaviController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.tabBarController?.viewControllers![1] = DoNotRVNaviController
        self.tabBarController?.selectedIndex = 1
    }
    
    func presentRVAlert() {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationAlertViewController") as! ReservationAlertViewController
        vc.delegate = self
        vc.type = .cancel
        self.tabBarController?.present(vc, animated: true, completion: nil)
    }
}
