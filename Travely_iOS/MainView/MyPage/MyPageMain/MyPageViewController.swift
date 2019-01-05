//
//  MyPageViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    let networkManager = NetworkManager()
    @IBOutlet weak var myPageTableView: UITableView!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPageTableView.delegate = self
        self.myPageTableView.dataSource = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
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
                
            }
        }

        // Do any additional setup after loading the view.
    }
  

}
extension MyPageViewController: UITableViewDelegate
{
    
}
extension MyPageViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentstoragecell") as! RecentStorageTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    
}
