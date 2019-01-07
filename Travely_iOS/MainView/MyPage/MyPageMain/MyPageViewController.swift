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
    
    
    
    
    @IBAction func luggageStatusButtonAction(_ sender: Any) {
        
        
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
     
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        myPageNetworking()
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
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        cell.separatorInset = UIEdgeInsets.zero
        cell.recentStorageNameLabel.text = self.gsno(profileModel?.storeInfoResponseDtoList?[indexPath.row].storeName)
        cell.recentStorageAddressLabel.text = self.gsno(profileModel?.storeInfoResponseDtoList?[indexPath.row].address)
        cell.recentStorageImg.imageFromUrl(self.gsno(profileModel?.storeInfoResponseDtoList?[indexPath.row].storeImage))
        
        return cell
    }
    
    
}
extension MyPageViewController: MakeReviewPresentView {
    func makeReview(onCell: RecentStorageTableViewCell) {
        let indexPath = self.myPageTableView.indexPath(for: onCell)
         let makeReview = UIStoryboard.init(name: "Alert", bundle: nil).instantiateViewController(withIdentifier: "makereview") as! MakeReviewPopupViewController
        makeReview.delegate = self
        makeReview.storeIdx = gino(self.profileModel?.storeInfoResponseDtoList?[(indexPath?.row)!].storeIdx)
        self.tabBarController?.present(makeReview, animated: true, completion: nil)
    }
}
