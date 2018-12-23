//
//  ViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/23/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit
import GoogleMaps

class MainViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var currentLocLB: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var hideBtn: UIBarButtonItem!
    
    lazy var searchTableView :UIView = UIView.init(frame: CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height))
    
    lazy var mapView = GMSMapView.map(withFrame: CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), camera: GMSCameraPosition.camera(withLatitude: 37.558514, longitude: 126.925239, zoom: 15))
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        //main 뷰에 mapView를 추가하고 지도뷰 위에 searchView와 searchTableView를 추가한다
        mapView.isMyLocationEnabled = true
        self.view.addSubview(mapView)
        mapView.addSubview(searchView)
        mapView.addSubview(searchTableView)

        //네비게이션바를 투명하게 해서 뒤에 mapView를 보여준다
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        hideBtn.title = ""
        hideBtn.isEnabled = false
        
        //searchTableView
         searchTableView.backgroundColor = UIColor.gray
        
    }
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
 
    @IBAction func SearchViewBtnAction(_ sender: Any) {
        
        //searchTabelView Animation
        UIView.animate(withDuration: 0.1, animations: {
            self.searchTableView.transform = CGAffineTransform(translationX: 0, y:-(self.view.frame.size.height - self.searchView.frame.maxY))
        }, completion: nil)
        
        //네비게이션바의 투명을 해제하고 white컬러로 바꿈
        self.searchView.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        hideBtn.title = "뒤로가기"
        hideBtn.isEnabled = true
        self.tabBarController?.hideTabBarAnimated(hide: true)
    }
    
    @IBAction func hideBtnAction(_ sender: Any) {
        
        //searchTabelView Animation
        UIView.animate(withDuration: 0.1, animations: {
            self.searchTableView.transform = CGAffineTransform(translationX: 0, y:self.view.frame.size.height)
        }, completion: nil)
        
        //네비게이션바의 투명을 설정
        self.searchView.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        hideBtn.title = ""
        hideBtn.isEnabled = false
        self.tabBarController?.hideTabBarAnimated(hide: false)
        
    }

    
}

