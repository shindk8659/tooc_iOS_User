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
    @IBOutlet weak var currentLocationView: UIView!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var hideBtn: UIBarButtonItem!
    @IBOutlet weak var shopDetailView: UITableView!
    @IBOutlet weak var shopSimpleInfoView: UIView!
    @IBOutlet weak var shopDetailHeaderView: UIView!
    
    lazy var shopSlideImageView :UIView = UIView.init(frame: CGRect(x: 0, y: -217, width: self.view.frame.size.width, height: 217))

    lazy var searchTableView: ExpandableTableView = ExpandableTableView.init(frame: CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height))
    
    lazy var mapView = GMSMapView.map(withFrame: CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), camera: GMSCameraPosition.camera(withLatitude: 37.558514, longitude: 126.925239, zoom: 15))
    
 
    let marker = GMSMarker()
    let networkManager = NetworkManager()
    var regionListModel: [RegionListModel?]?
    var storeListModel: [StoreListModel?]?
    var storeDetailModel: StoreDetailModel?
    
    //titleImage
    let titleImageView = UIImageView.init(image: UIImage.init(named: "tooc"))
    
    
    //shopsimpleInfoview IBOulet
    @IBOutlet weak var simpleInfoStoreNameLabel: UILabel!
    @IBOutlet weak var simpleInfoAddressLabel: UILabel!
    @IBOutlet weak var simpleInfoTimeLabel: UILabel!
  
    
    //shopDetailView IBOulet
    @IBOutlet weak var detailStoreNameLabel: UILabel!
    @IBOutlet weak var detailGradeLabel: UILabel!
    

    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //navigationBar title image
        self.navigationItem.titleView = titleImageView
    
        currentLocationView.layer.cornerRadius = 5
        currentLocationView.layer.masksToBounds = true
        searchButtonView.layer.cornerRadius = 5
        searchButtonView.layer.masksToBounds = true
        

        //Expandable tableview delegate
        searchTableView.expandableDelegate = self
        searchTableView.animation = .automatic
        searchTableView.separatorStyle = .singleLine
        searchTableView.tableFooterView = UIView()
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
        marker.icon = UIImage.init(named: "<#T##String#>")
        
        self.view.addSubview(mapView)
        self.view.addSubview(shopSlideImageView)
        self.view.addSubview(shopDetailView)
        self.view.addSubview(shopSimpleInfoView)
        self.view.addSubview(searchView)
        self.view.addSubview(searchTableView)


        //네비게이션바를 투명하게 해서 뒤에 mapView를 보여준다
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        hideBtn.image = nil
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
        
        //shopSimpleInfoView 히든처리
        shopSimpleInfoView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        //Expandable tableview delegate
        searchTableView.expandableDelegate = self
        searchTableView.animation = .automatic
        searchTableView.separatorStyle = .singleLine
        searchTableView.tableFooterView = UIView()
        searchTableView.register(UINib(nibName: "DetailShopTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailShopTableViewCell")
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        self.view.addSubview(searchTableView)
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
            self.navigationItem.titleView = nil
            self.navigationItem.title = ""
            self.tabBarController?.tabBar.isHidden = true
        }
        
    }
    
    //swipe Gesture upside
    @objc func handleSwipeUpGesture(recognizer: UISwipeGestureRecognizer) {
        if self.shopDetailView.frame.origin.y == 217
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.shopDetailView.frame = CGRect(x: 0, y: self.view.safeAreaInsets.bottom, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
                self.shopSlideImageView.frame = CGRect(x: 0, y: -217, width: self.shopSlideImageView.frame.width, height: self.shopSlideImageView.frame.height)
                self.searchView.isHidden = true
            }) { [weak self](true) in
                self?.shopDetailView.isScrollEnabled = true
            }
        

            //네비게이션바의 투명을 해제하고 white컬러로 바꿈
            self.navigationController?.navigationBar.backgroundColor = UIColor.white
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationItem.titleView = titleImageView
            hideBtn.image = UIImage.init(named: "icBack.png")
            hideBtn.isEnabled = true
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    //swipe Gesture downside
    @objc func handleSwipeDownGesture(recognizer: UISwipeGestureRecognizer) {
        if self.shopDetailView.frame.origin.y == self.view.safeAreaInsets.bottom && self.shopDetailView.contentOffset.y < 0 {
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
            self.navigationItem.titleView = nil
            self.navigationItem.title = ""
            hideBtn.image = nil
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
            self.navigationItem.titleView = titleImageView
            self.tabBarController?.tabBar.isHidden = false
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
            self.searchTableView.frame = CGRect(x: 0, y: self.searchView.frame.maxY, width: self.searchTableView.frame.width, height: self.view.frame.size.height - self.searchView.frame.maxY)
        }, completion: nil)
        
        networkManager.regionList{ [weak self](regionList, errorModel, error) in
            // 지역 리스트 네트워크 처리
            if regionList == nil && errorModel == nil && error != nil {
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController,animated: true,completion: nil)
            }
                // 서버측 에러핸들러 구성후 바꿔야함
            else if regionList == nil && errorModel != nil && error == nil {
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController,animated: true,completion: nil)
            }
            else {
                self?.regionListModel = regionList
                self?.searchTableView.reloadData()
            }
        }
            
        
        
        //네비게이션바의 투명을 해제하고 white컬러로 바꿈
        self.searchView.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        hideBtn.image = UIImage.init(named: "icBack.png")
        hideBtn.isEnabled = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //처음상태로 변경 SearchTableView를 내린다.
    @IBAction func hideBtnAction(_ sender: Any) {
        if self.shopDetailView.frame.origin.y == self.view.safeAreaInsets.bottom{
            self.shopDetailView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.shopDetailView.isScrollEnabled = false
            UIView.animate(withDuration: 0.3, animations: {
                self.shopDetailView.frame = CGRect(x: 0, y: self.view.frame.height-150, width: self.shopDetailView.frame.width, height: self.shopDetailView.frame.height)
                self.shopSlideImageView.frame = CGRect(x: 0, y: -217, width: self.shopSlideImageView.frame.width, height: self.shopSlideImageView.frame.height)
                self.searchView.isHidden = false
            }) { [weak self](true) in
                self?.shopSimpleInfoView.isHidden = false
            }
            self.tabBarController?.tabBar.isHidden = false
        }
        else if self.searchTableView.frame.origin.y == self.searchView.frame.maxY {
            //searchTabelView Animation
            self.searchTableView.closeAll()
            self.searchView.backgroundColor = UIColor.clear
            UIView.animate(withDuration: 0.3, animations: {
                self.searchTableView.frame = CGRect(x: 0, y:self.view.frame.size.height, width: self.searchTableView.frame.width, height: self.searchTableView.frame.height)
            }, completion: nil)
            self.tabBarController?.tabBar.isHidden = false
        }
        //네비게이션바의 투명을 설정
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationItem.titleView = titleImageView
        hideBtn.image = nil
        hideBtn.isEnabled = false
    }
    
    func setStoreTime(openTime: String?, closeTime: String?) -> String{
        if openTime != nil && closeTime != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let open = dateFormatter.date(from: openTime!)
            let close = dateFormatter.date(from: closeTime!)
        
        //전체시간에서 시간 만 땡기기
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "HH:mm"
            let openTime = dateFormatter2.string(from: open!)
            let closeTime = dateFormatter2.string(from: close!)
            let wholeTime = "매일 \(openTime) ~ \(closeTime)"
            return wholeTime
            
        }
        else {
            return ""
        }
        
    }
    
    
    
}

//ExpandableCell 라이브러리 딜리케이트 코드 
extension MainViewController: ExpandableDelegate {
    
    //상위 셀
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        cell.separatorInset = UIEdgeInsets.zero
        cell.regionName.text = regionListModel?[indexPath.row]?.regionName

        return cell
    }
    
    
    //하위 셀
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        var cellArray = Array<UITableViewCell>()
        let count = gino( regionListModel?[indexPath.row]?.simpleStoreResponseDtos?.count)
        for i in 0..<count {
            let cell1 = searchTableView.dequeueReusableCell(withIdentifier: "DetailShopTableViewCell") as! DetailShopTableViewCell
            cell1.selectionStyle = UITableViewCell.SelectionStyle.none;
            cell1.storeName.text = regionListModel?[indexPath.row]?.simpleStoreResponseDtos?[i].storeName
            cell1.simpleStoreInfo = regionListModel?[indexPath.row]?.simpleStoreResponseDtos?[i]
            cellArray.append(cell1)
        }
        return cellArray
    }
    
    //하위 셀 사이즈
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        let  expandCount = gino( regionListModel?[indexPath.row]?.simpleStoreResponseDtos?.count)
        var cellSize = Array<CGFloat>()
        for _ in 0 ..< expandCount {
            cellSize.append(40)
        }
        return cellSize
    }
    
    //섹션 개수
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return 1
    }
    
    //하위 셀 개수
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        if regionListModel?.count != 0 {
            return gino(regionListModel?.count)
        }
        return 0
    }
    
    //하위 셀 selection event
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
            let storeIndex = expandableTableView.cellForRow(at: indexPath) as! DetailShopTableViewCell
            
            //storeDetailModel 데이터를 뷰에 셋한다.
            networkManager.storeDetail(storeIdx: gino(storeIndex.simpleStoreInfo?.storeIdx)) { [weak self](storeDetail, errorModel, error) in
                
                // 지역 리스트 네트워크 처리
                if storeDetail == nil && errorModel == nil && error != nil {
                    let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                    let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    alertController.addAction(cancelButton)
                    self?.present(alertController,animated: true,completion: nil)
                }
                    // 서버측 에러핸들러 구성후 바꿔야함
                else if storeDetail == nil && errorModel != nil && error == nil {
                    let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                    let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    alertController.addAction(cancelButton)
                    self?.present(alertController,animated: true,completion: nil)
                }
                else {
                    //심플 상점 데이터
                    self?.storeDetailModel = storeDetail
                    self?.simpleInfoStoreNameLabel.text = storeDetail?.storeName
                    self?.simpleInfoAddressLabel.text = storeDetail?.address
                    self?.simpleInfoTimeLabel.text = self?.setStoreTime(openTime:storeDetail?.openTime, closeTime: storeDetail?.closeTime)
                    
                    //디테일 상점 테이블뷰
                    self?.detailStoreNameLabel.text = storeDetail?.storeName
                    self?.detailGradeLabel.text = "\(String(describing: (storeDetail?.grade)!))점"
                    self?.detailGradeLabel.sizeToFit()
                    self?.searchTableView.closeAll()
                    self?.shopDetailView.reloadData()
                    
                 
                    //지도 마커
                    self?.marker.map = nil
                    self?.marker.position = CLLocationCoordinate2D(latitude: (storeDetail?.latitude)!, longitude: (storeDetail?.longitude)!)
                    self?.marker.map = self?.mapView
                    self?.mapView.camera = GMSCameraPosition.camera(withTarget: (self?.marker.position)!, zoom: 16)
                    
                    
                }
            }
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
            hideBtn.image = nil
            hideBtn.isEnabled = false
            self.tabBarController?.tabBar.isHidden = false
        
        
    }
    
    // 섹션 이름 설정
    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName:String
        sectionName = "지역별 보관장소 (\(gino(regionListModel?.count)))"
        
        return sectionName
    }
    
    //섹션 헤더 크기
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //섹션 상위 셀 크기
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52.5
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        else {
            if storeDetailModel?.reviewResponseDtos?.count != 0 {
                 return gino(storeDetailModel?.reviewResponseDtos?.count)
            }
            else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopaddresscell") as! ShopAddressTableViewCell
            cell.shopAddressLabel.text = storeDetailModel?.address
           //cell.shopOldAddressLabel.text = self.storeDetailModel.
            cell.shopTimeLabel.text = setStoreTime(openTime:storeDetailModel?.openTime, closeTime: storeDetailModel?.closeTime)
            cell.shopWebsiteLabel.text = storeDetailModel?.address
            cell.shopCallNumLabel.text = storeDetailModel?.storeCall
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewheadercell") as! ReviewHeaderTableViewCell
            cell.separatorInset = .zero
            if storeDetailModel?.reviewResponseDtos?.count != 0 {
                 cell.reviewCountLabel.text = "\(String(describing: gino(storeDetailModel?.reviewResponseDtos?.count)))"
            }
            else {
                cell.reviewCountLabel.text = "\(String(describing: 0))"
            }
           
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopreviewcell") as! ShopReviewTableViewCell
            cell.userGradeLabel.text = "\(String(describing: (storeDetailModel?.reviewResponseDtos?[indexPath.row].like)!))점"
            cell.userReviewTextView.text = storeDetailModel?.reviewResponseDtos?[indexPath.row].content
            
            return cell
        }
        
    }
  
    
    
    
    
}
extension MainViewController: UITableViewDelegate
{

     
}


