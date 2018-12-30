//
//  ViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/23/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit
import GoogleMaps
import ExpandableCell

class MainViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate{
   
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var currentLocLB: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var hideBtn: UIBarButtonItem!
    @IBOutlet weak var shopDetailView: UITableView!
    @IBOutlet weak var shopSimpleInfoView: UIView!
    @IBOutlet weak var shopDetailHeaderView: UIView!
    
    lazy var shopSlideImageView :UIView = UIView.init(frame: CGRect(x: 0, y: -217, width: self.view.frame.size.width, height: 217))

    lazy var searchTableView: ExpandableTableView = ExpandableTableView.init(frame: CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - self.searchView.frame.maxY))
    
    lazy var mapView = GMSMapView.map(withFrame: CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), camera: GMSCameraPosition.camera(withLatitude: 37.558514, longitude: 126.925239, zoom: 15))
    
    let marker = GMSMarker()
    let marker2 = GMSMarker()
    
    let networkManager = NetworkManager()
    let userdata = UserDefaults.standard

    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        shopSimpleInfoView.isHidden = true
        //Expandable tableview delegate
        searchTableView.expandableDelegate = self
        searchTableView.animation = .automatic
        searchTableView.register(UINib(nibName: "DetailShopTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailShopTableViewCell")
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
    
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        //shopDetailView
        shopDetailView.delegate = self
        shopDetailView.dataSource = self
        shopDetailView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        shopDetailView.isScrollEnabled = false
        //shopSlideImageView
        shopSlideImageView.backgroundColor = UIColor.gray
        //main 뷰에 mapView를 추가하고 지도뷰 위에 searchView와 searchTableView shopDetailView를 추가한다
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        self.view.addSubview(mapView)
        self.view.addSubview(shopSlideImageView)
        self.view.addSubview(shopDetailView)
        self.view.addSubview(shopSimpleInfoView)
        self.view.addSubview(searchView)
        self.view.addSubview(searchTableView)
        
    
        //지도 마커
        marker.position = CLLocationCoordinate2D(latitude: 37.556027, longitude: 126.922949)
        marker.map = mapView
        marker2.position = CLLocationCoordinate2D(latitude: 37.582307, longitude: 127.034302)
        marker2.map = mapView

        //네비게이션바를 투명하게 해서 뒤에 mapView를 보여준다
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        hideBtn.title = ""
        hideBtn.isEnabled = false
        
        //swipeGesture
        let shopSimpleInfoSwipeUp = UISwipeGestureRecognizer(target: self, action:#selector(handleSimpleInfoSwipeUpGesture))
        let swipeUp = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipeUpGesture))
        let swipeDown = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipeDownGesture))
        
        shopSimpleInfoSwipeUp.direction = .up
        swipeUp.direction = .up
        swipeDown.direction = .down
        
        shopSimpleInfoSwipeUp.delegate = self
        swipeDown.delegate = self
        swipeUp.delegate = self
        
        shopSimpleInfoView.addGestureRecognizer(shopSimpleInfoSwipeUp)
        shopDetailView.addGestureRecognizer(swipeDown)
        shopDetailView.addGestureRecognizer(swipeUp)
        
      
       
    }
    
    func gestureRecognizer(_: UIGestureRecognizer,shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
    
    //swipe Gesture upside
    @objc func handleSimpleInfoSwipeUpGesture(recognizer: UISwipeGestureRecognizer) {
        if self.shopDetailView.frame.origin.y == self.view.frame.height-150{
            self.shopSimpleInfoView.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.shopDetailView.frame = CGRect(x: 0, y: 217, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
                self.shopSlideImageView.frame = CGRect(x: 0, y: 0, width: self.shopSlideImageView.frame.width, height: self.shopSlideImageView.frame.height)
                self.searchView.isHidden = true
            },completion: nil)
            self.navigationItem.title = ""
            self.tabBarController?.hideTabBarAnimated(hide: true)
        }
        
    }
    
    //swipe Gesture upside
    @objc func handleSwipeUpGesture(recognizer: UISwipeGestureRecognizer) {
        if self.shopDetailView.frame.origin.y == 217
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.shopDetailView.frame = CGRect(x: 0, y: 0, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
                self.shopSlideImageView.frame = CGRect(x: 0, y: -217, width: self.shopSlideImageView.frame.width, height: self.shopSlideImageView.frame.height)
                self.searchView.isHidden = true
            }) { [weak self](true) in
                self?.shopDetailView.isScrollEnabled = true
            }
        

            //네비게이션바의 투명을 해제하고 white컬러로 바꿈
            self.navigationController?.navigationBar.backgroundColor = UIColor.white
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationItem.title = "동대문엽기떡볶이 홍대점"
            hideBtn.title = "뒤로가기"
            hideBtn.isEnabled = true
            self.tabBarController?.hideTabBarAnimated(hide: true)
        }
    }
    
    //swipe Gesture downside
    @objc func handleSwipeDownGesture(recognizer: UISwipeGestureRecognizer) {
        if self.shopDetailView.frame.origin.y == 0 && self.shopDetailView.contentOffset.y < 0 {
            self.shopDetailView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.shopDetailView.isScrollEnabled = false
            UIView.animate(withDuration: 0.3, animations: {
                self.shopDetailView.frame = CGRect(x: 0, y: 217, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
                self.shopSlideImageView.frame = CGRect(x: 0, y: 0, width: self.shopSlideImageView.frame.width, height: self.shopSlideImageView.frame.height)
                self.searchView.isHidden = true
                
            } ,completion: nil)
            //네비게이션바의 투명을 설정
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear
            self.navigationItem.title = ""
            hideBtn.title = ""
            hideBtn.isEnabled = false
        }
        else if self.shopDetailView.frame.origin.y == 217{
            
            UIView.animate(withDuration: 0.3, animations: {
                self.shopDetailView.frame = CGRect(x: 0, y: self.view.frame.height-150, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
                self.shopSlideImageView.frame = CGRect(x: 0, y: -217, width: self.shopSlideImageView.frame.width, height: self.shopSlideImageView.frame.height)
                self.searchView.isHidden = false
            }) { [weak self](true) in
                 self?.shopSimpleInfoView.isHidden = false
            }
            self.navigationItem.title = "Tooc"
            self.tabBarController?.hideTabBarAnimated(hide: false)
        }
    }
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        self.mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
    
    //어디로 가십니까? 버튼을 눌렀을경우 SearchTableView를 띄우고 searchView의 생상과 navigationBar의 투명을 변경한다.
    @IBAction func SearchViewBtnAction(_ sender: Any) {
        
        //searchTabelView Animation
        UIView.animate(withDuration: 0.3, animations: {
            self.searchTableView.frame = CGRect(x: 0, y: self.searchView.frame.maxY, width: self.searchTableView.frame.width, height: self.searchTableView.frame.height)
        }, completion: nil)
        
        networkManager.regionList(jwt: userdata.string(forKey: "jwt")!) { (regionList, errorModel, error) in
           
        }
        //네비게이션바의 투명을 해제하고 white컬러로 바꿈
        self.searchView.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        hideBtn.title = "뒤로가기"
        hideBtn.isEnabled = true
        self.tabBarController?.hideTabBarAnimated(hide: true)
    }
    
    //처음상태로 변경 SearchTableView를 내린다.
    @IBAction func hideBtnAction(_ sender: Any) {
        if self.shopDetailView.frame.origin.y == 0 {
            self.shopDetailView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.shopDetailView.isScrollEnabled = false
            UIView.animate(withDuration: 0.3, animations: {
                self.shopDetailView.frame = CGRect(x: 0, y: self.view.frame.height-150, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
                self.shopSlideImageView.frame = CGRect(x: 0, y: -217, width: self.shopSlideImageView.frame.width, height: self.shopSlideImageView.frame.height)
                self.searchView.isHidden = false
            }) { [weak self](true) in
                self?.shopSimpleInfoView.isHidden = false
            }
            self.tabBarController?.hideTabBarAnimated(hide: false)
        }
        else {
            //searchTabelView Animation
            self.searchTableView.closeAll()
            self.searchView.backgroundColor = UIColor.clear
            UIView.animate(withDuration: 0.3, animations: {
                self.searchTableView.frame = CGRect(x: 0, y:self.view.frame.size.height, width: self.searchTableView.frame.width, height: self.searchTableView.frame.height)
            }, completion: nil)
            self.tabBarController?.hideTabBarAnimated(hide: false)
        }
        //네비게이션바의 투명을 설정
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationItem.title = "Tooc"
        hideBtn.title = ""
        hideBtn.isEnabled = false
    }
    
}

//ExpandableCell 라이브러리 딜리케이트 코드 
extension MainViewController: ExpandableDelegate {
    
    //상위 셀
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        return cell
    }
    
    //하위 셀
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        switch indexPath.section {
        case 0:
            var cellArray = Array<UITableViewCell>()
            let count = 3
            for _ in 0..<count
            {
                let cell1 = searchTableView.dequeueReusableCell(withIdentifier: "DetailShopTableViewCell") as! DetailShopTableViewCell
                cell1.selectionStyle = UITableViewCell.SelectionStyle.none;
                cellArray.append(cell1)
            }
            return cellArray
            
        case 1:
            var cellArray = Array<UITableViewCell>()
            let count = 3
            for _ in 0..<count
            {
                let cell1 = searchTableView.dequeueReusableCell(withIdentifier: "DetailShopTableViewCell") as! DetailShopTableViewCell
                cell1.selectionStyle = UITableViewCell.SelectionStyle.none;
                cellArray.append(cell1)
            }
            return cellArray
            
        default:
            break
        }
        return nil
    }
    
    //하위 셀 사이즈
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        switch indexPath.section {
        case 0:
                return [44, 44, 44]
        case 1:
                return [44, 44, 44]
        default:
            break
        }
        return nil
        
    }
    
    //섹션 개수
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return 2
    }
    
    //하위 셀 개수
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //하위 셀 selection event
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            expandableTableView.closeAll()
            //searchTabelView shopDetailView Animation
            self.shopSimpleInfoView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
               self.searchTableView.frame = CGRect(x: 0, y:self.view.frame.height, width: self.searchTableView.frame.width, height: self.searchTableView.frame.height)
                self.shopDetailView.frame = CGRect(x: 0, y: self.view.frame.height-150, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
            }, completion: nil)
            
            //네비게이션바의 투명을 설정
            self.searchView.backgroundColor = UIColor.clear
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear
            hideBtn.title = ""
            hideBtn.isEnabled = false
            self.tabBarController?.hideTabBarAnimated(hide: false)
            mapView.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 16)
        }
            
        else {
            expandableTableView.closeAll()
            //searchTabelView shopDetailView Animation
              self.shopSimpleInfoView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.searchTableView.frame = CGRect(x: 0, y:self.view.frame.height, width: self.searchTableView.frame.width, height: self.searchTableView.frame.height)
                self.shopDetailView.frame = CGRect(x: 0, y: self.view.frame.height-150, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
            }, completion: nil)
            
            //네비게이션바의 투명을 설정
            self.searchView.backgroundColor = UIColor.clear
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear
            hideBtn.title = ""
            hideBtn.isEnabled = false
            self.tabBarController?.hideTabBarAnimated(hide: false)
            mapView.camera = GMSCameraPosition.camera(withTarget: marker2.position, zoom: 16)
        }
    }
    
    // 섹션 이름 설정
    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName:String
        switch (section) {
        case 0:
            sectionName = "지역별 보관장소"
            break
       default:
            sectionName = "가까운 보관장소"
            break
        }
        return sectionName
    }
    
    //섹션 헤더 크기
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    //섹션 상위 셀 크기
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 66
        case 1:
            return 66
        default:
            break
        }
        
        return 44
    }

    //
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func expandableTableView(_ expandableTableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {

    }
}

extension MainViewController: GMSMapViewDelegate
{
    //mapView tap 했을 경우 뷰를 내려가게 한다.
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //shopDetailView Animation
        UIView.animate(withDuration: 0.3, animations: {
            self.shopSimpleInfoView.isHidden = true
             self.shopDetailView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
        }, completion: nil)
        
    }
    
}
extension MainViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopaddresscell") as! ShopAddressTableViewCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopreviewcell") as! ShopReviewTableViewCell
            return cell
        }
        
    }
    
    
}
extension MainViewController: UITableViewDelegate
{
  
    
}


