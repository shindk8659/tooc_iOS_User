//
//  MyPageViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController,ReloadViwDelegate {
    func reloadView() {
        self.myPageNetworking()
    }
    

    let networkManager = NetworkManager()
    var profileModel: ProfileModel?
    @IBOutlet weak var myPageTableView: UITableView!
    //마이페이지 아울렛
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myLuggageStatusCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBAction func appStatusButtonAction(_ sender: Any) {
        let appstatusVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "appstatus")
        appstatusVC.addBackButton("black")
        self.navigationController?.pushViewController(appstatusVC, animated: true)
    
    }
    @IBAction func favoriteButtonAction(_ sender: Any) {
        let favoriteVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "favoritestoreview") as! FavoriteStoreViewController
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    
    @IBAction func myreviewButtonAction(_ sender: Any) {
        let myreviewVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myreviewview") as! MyReviewViewController
        self.navigationController?.pushViewController(myreviewVC, animated: true)
        
    }
    
    func myPageNetworking() {
        networkManager.getProfileInfo { [weak self](profile, errorModel, error) in
            // 로그인 네트워크 처리
            if profile == nil && errorModel == nil && error != nil {
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController,animated: true,completion: nil)
            }
            else if profile == nil && errorModel != nil && error == nil {
                let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(cancelButton)
                self?.present(alertController,animated: true,completion: nil)
            }
            else {
                self?.profileModel = profile
                self?.nameLabel.text = (profile?.name)! + "님,"
                self?.myLuggageStatusCountLabel.text =
                "\((profile?.myBagCount)!)"
                self?.favoriteCountLabel.text =
                "\((profile?.favoriteCount)!)"
                self?.reviewCountLabel.text =
                "\((profile?.reviewCount)!)"
                self?.myPageTableView.reloadData()
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPageTableView.delegate = self
        self.myPageTableView.dataSource = self
       
     
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        myPageNetworking()
    }
    
    func setStoreTime(openTime: Int?, closeTime: Int?) -> String{
        if openTime != nil && closeTime != nil {
            
            // 개장시간과 폐장시간을 timeStemp 로 받아 Date객체로 변환
            let openTimestamp = gino(openTime)/1000
            let closeTemestamp = gino(closeTime)/1000
            let openDate = Date(timeIntervalSince1970: Double(gino(openTimestamp)))
            let closeDate = Date(timeIntervalSince1970: Double(gino(closeTemestamp)))
            
            // Date객체에서 가져올 포맷과 시간대를 정하고 String 으로 꺼내서 반환 함
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+9") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
            let open = dateFormatter.string(from: openDate)
            let close = dateFormatter.string(from: closeDate)
            let wholeTime = "매일 \(open) ~ \(close)"
            return wholeTime
        }
        else {
            return ""
        }
        
    }
    
    
}
extension MyPageViewController: UITableViewDelegate
{
    
}
extension MyPageViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gino(profileModel?.storeInfoResponseDtoList?.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentstoragecell") as! RecentStorageTableViewCell
        cell.delegate = self
        
        //마이페이지예약
        //이전뷰에서 가져온 데이터들
        cell.storeIdx = self.gino(profileModel?.storeInfoResponseDtoList?[indexPath.row].storeIdx)
        cell.closeTime = self.gino(profileModel?.storeInfoResponseDtoList?[indexPath.row].closeTime)
        cell.currentBag  = self.gino(profileModel?.storeInfoResponseDtoList?[indexPath.row].currentBag)
        cell.limit = self.gino(profileModel?.storeInfoResponseDtoList?[indexPath.row].limit)
        cell.opentime = self.gino(profileModel?.storeInfoResponseDtoList?[indexPath.row].openTime)
        cell.available = self.gino(profileModel?.storeInfoResponseDtoList?[indexPath.row].available)
        cell.restWeekResponseDtos = profileModel?.storeInfoResponseDtoList?[indexPath.row].restWeekResponseDtos
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        cell.separatorInset = UIEdgeInsets.zero
        cell.recentStorageNameLabel.text = self.gsno(profileModel?.storeInfoResponseDtoList?[indexPath.row].storeName)
        cell.recentStorageAddressLabel.text = self.gsno(profileModel?.storeInfoResponseDtoList?[indexPath.row].address)
        cell.recentStorageImg.imageFromUrl(self.gsno(profileModel?.storeInfoResponseDtoList?[indexPath.row].storeImage))
        let time = setStoreTime(openTime: self.gino(profileModel?.storeInfoResponseDtoList?[indexPath.row].openTime), closeTime: self.gino(profileModel?.storeInfoResponseDtoList?[indexPath.row].closeTime))
        cell.recentStorageTimeLabel.text = time
        return cell
    }
    
    
}
extension MyPageViewController: MakeReviewPresentView {
 
    func makeReservation(storeIdx: Int, closeTime: Int, currentBag: Int, limit: Int, opentime: Int,available:Int, restWeekResponseDtos: [RestWeekResponseDtos?]?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReservationViewController") as! ReservationViewController
        vc.closeTime = closeTime
        vc.currentBag = currentBag
        vc.limit = limit
        vc.opentime = opentime
        vc.restWeekResponseDtos = restWeekResponseDtos
        vc.storeIdx = storeIdx
        vc.available = available
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func makeReview(onCell: RecentStorageTableViewCell) {
        let indexPath = self.myPageTableView.indexPath(for: onCell)
         let makeReview = UIStoryboard.init(name: "Alert", bundle: nil).instantiateViewController(withIdentifier: "makereview") as! MakeReviewPopupViewController
        makeReview.delegate = self
        makeReview.storeIdx = gino(self.profileModel?.storeInfoResponseDtoList?[(indexPath?.row)!].storeIdx)
        self.tabBarController?.present(makeReview, animated: true, completion: nil)
    }
}
