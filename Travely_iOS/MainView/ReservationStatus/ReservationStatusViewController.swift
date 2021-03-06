//
//  ReservationStatusViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 01/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import GoogleMaps

class ReservationStatusViewController: UITableViewController,CLLocationManagerDelegate {
    
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
    
    @IBOutlet weak var reservationLocationInfoCell: UITableViewCell!
    @IBAction func didPressRVCancel(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "cancelConfirmViewController") as! cancelConfirmViewController
        vc.delegate = self
        self.tabBarController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func findPath(_ sender: UIButton) {
        
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            
            let appleMapInstalled = UIApplication.shared.canOpenURL(URL(string: "http://maps.apple.com/")!)
            let kakaoMapInstalled = UIApplication.shared.canOpenURL(URL(string: "daummaps://")!)
            if (!appleMapInstalled){
                let appleButton = UIAlertAction(title: "애플 지도 다운받기", style: .default, handler: {(alert: UIAlertAction!) in
                    UIApplication.shared.open(URL(string: "http://maps.apple.com/?saddr=\((self.locationManager.location?.coordinate.latitude)!),\((self.locationManager.location?.coordinate.longitude)!)&daddr=\((self.latitude)!),\((self.longitude)!)")! as URL, options: [:], completionHandler: nil)})
                alertController.addAction(appleButton)
                
            }
            else {
                let appleButton = UIAlertAction(title: "애플 지도", style: .default, handler: {(alert: UIAlertAction!) in
                    UIApplication.shared.open(URL(string: "http://maps.apple.com/?saddr=\((self.locationManager.location?.coordinate.latitude)!),\((self.locationManager.location?.coordinate.longitude)!)&daddr=\((self.latitude)!),\((self.longitude)!)")! as URL, options: [:], completionHandler: nil)})
                alertController.addAction(appleButton)
                
            }
            
            if (!kakaoMapInstalled){
                let appleDownButton = UIAlertAction(title: "카카오 맵 다운받기", style: .default, handler: {(alert: UIAlertAction!) in
                    UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/id304608425?mt=8")! as URL, options: [:], completionHandler: nil)})
                alertController.addAction(appleDownButton)
            }
            else {
                let kakaoButton = UIAlertAction(title: "카카오 맵", style: .default, handler: {(alert: UIAlertAction!) in
                    UIApplication.shared.open(URL(string: "daummaps://route?sp=\((self.locationManager.location?.coordinate.latitude)!),\((self.locationManager.location?.coordinate.longitude)!)&ep=\((self.latitude)!),\((self.longitude)!)&by=CAR")! as URL, options: [:], completionHandler: nil)})
                alertController.addAction(kakaoButton)
                
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {(alert: UIAlertAction!) in alertController.dismiss(animated: true, completion: nil)})
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion:{})
            
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
    var reservationInfo:ReservationInfo?
    
    // locationManager
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleImageView
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        layoutSetup()
        
        let userDefaults = UserDefaults()
        userDefaults.set(true, forKey: "isReserve")
        userDefaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            network()
            totalTime.text = UserDefaults.standard.string(forKey: "totalTime")
    }
    
    func network() {
        networkManager.bringReservationInfo { [weak self] (result, errorModel, error) in
            if result == nil && errorModel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
            }
                // 서버측 에러핸들러 구성후 바꿔야함
            else if result == nil && errorModel != nil && error == nil {
                let DoNotRVNaviViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DoNotRVNavi")
                DoNotRVNaviViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_reservation_gray_tab"),tag: 1)
                DoNotRVNaviViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
                self?.tabBarController?.viewControllers![1] = DoNotRVNaviViewController
                self?.tabBarController?.selectedIndex = 1
            }
            else {
                self?.reservationInfo = result
                self?.paymentState = result?.stateType
                switch self!.paymentState {
                case "RESERVED":
                    self?.statusProgressView[0].backgroundColor = .white
                case "PAYED":
                    self?.statusProgressView[0].backgroundColor = .white
                    self?.statusProgressView[1].backgroundColor = .white
                case "ARCHIVE":
                    self?.statusProgressView[0].backgroundColor = .white
                    self?.statusProgressView[1].backgroundColor = .white
                    self?.statusProgressView[2].backgroundColor = .white
                    
                    let bagImgDtos = result?.bagImgDtos
                    var count = 0
                    
                    for img in bagImgDtos! {
                        let ImgURL = img.bagImgUrl
                        self?.bagImages[count].imageFromUrl(ImgURL)
                        self?.bagImages[count].contentMode = .scaleAspectFit
                        count += 1
                    }
                case "PICKUP":
                    self?.statusProgressView[0].backgroundColor = .white
                    self?.statusProgressView[1].backgroundColor = .white
                    self?.statusProgressView[2].backgroundColor = .white
                    self?.statusProgressView[3].backgroundColor = .white
                case "CANCEL":
                    break
                default: break
                }
                
                self?.reservationCode.text = result?.reserveCode
                
                let image = self!.generateQRCode(from: self!.reservationCode.text!)
                self?.qrCode.image = image
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yy년 M월 d일 E요일"
                dateFormatter1.locale = Locale(identifier:"ko_KR")
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "a h시 m분"
                dateFormatter2.locale = Locale(identifier:"ko_KR")
                
                self?.checkDate.text = dateFormatter1.string(from: Date(timeIntervalSince1970: TimeInterval((result?.startTime)!/1000)))
                self?.checkTime.text = dateFormatter2.string(from: Date(timeIntervalSince1970: TimeInterval((result?.startTime)!/1000)))
                
                self?.findDate.text = dateFormatter1.string(from: Date(timeIntervalSince1970: TimeInterval((result?.endTime)!/1000)))
                self?.findTime.text = dateFormatter2.string(from: Date(timeIntervalSince1970: TimeInterval((result?.endTime)!/1000)))
                
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
                self?.totalRateOfPayment.text = "\(totalPrice)원"
                self?.storeName.text = result?.store?.storeName
                self?.storeAdress.text = result?.store?.address
                
                self?.latitude = result?.store?.latitude
                self?.longitude = result?.store?.longitude
                
                let bagDtos = result?.bagDtos
                let unitPrice = result?.priceUnit ?? 0
                var totalCount = 0
                
                for bag in bagDtos! {
                    switch bag.bagType {
                    case "CARRIER" :
                        totalCount += bag.bagCount!
                        self?.suitcaseRate.text = "\(bag.bagCount ?? 0)개 \(unitPrice)원"
                    case "ETC" :
                        totalCount += bag.bagCount!
                        self?.luggageRate.text = "\(bag.bagCount ?? 0)개 \(unitPrice)원"
                    default: break
                    }
                }
                self?.totalRate.text = "요금: \(unitPrice)원 X \(totalCount)개"
                
                let open = Date(timeIntervalSince1970: TimeInterval((result?.store?.openTime)!/1000))
                let close = Date(timeIntervalSince1970: TimeInterval((result?.store?.closeTime)!/1000))
                
                dateFormatter2.dateFormat = "HH:mm"
                let openTime = dateFormatter2.string(from: open)
                let closeTime = dateFormatter2.string(from: close)
                self?.openTime.text = "매일 \(openTime)~\(closeTime) "
                
                if Date(timeIntervalSinceNow: 0).isDateAvailable(openTime: open, closeTime: close) {
                    self?.isOpenImg.image = UIImage(named: "ic_working")
                } else {
                    self?.isOpenImg.image = UIImage(named: "ic_end")
                }
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


