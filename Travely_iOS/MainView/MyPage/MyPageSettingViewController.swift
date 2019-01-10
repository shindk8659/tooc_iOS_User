//
//  MyPageSettingViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 09/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyPageSettingViewController: UITableViewController {
    
    @IBOutlet var languageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageView.layer.borderWidth = 1
        languageView.layer.borderColor = UIColor.lightGray.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapInside))
        languageView.addGestureRecognizer(tap)
    }
    
    @objc func tapInside() {
        showAlertMessage(titleStr: "", messageStr: "다른 언어는 차후 지원될 예정입니다.")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        self.tabBarController?.hideTabBarAnimated(hide: false)
    }
       override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            cell.selectionStyle = .none
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "aboutTooc")
            VC.addBackButton("black")
            self.navigationController?.pushViewController(VC, animated: true)
        case 3:
            let VC = UIStoryboard.init(name: "LoginSignup", bundle: nil).instantiateViewController(withIdentifier: "appguidepageview")
             self.tabBarController?.hideTabBarAnimated(hide: true)
             self.navigationController?.pushViewController(VC, animated: true)
            VC.addBackButton("black")
        case 4:
            let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "faqview") as! FAQViewController
            VC.addBackButton("black")
            self.navigationController?.pushViewController(VC, animated: true)
        case 5:
            let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InquiryViewController") as! InquiryViewController
            VC.addBackButton("black")
            self.navigationController?.pushViewController(VC, animated: true)
//            showAlertMessage(titleStr: "", messageStr: "준비중인 서비스 입니다.")
        case 6:
            let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "termofservice") as! WholeTermTableViewController
            VC.addBackButton("black")
            self.navigationController?.pushViewController(VC, animated: true)
        case 7:
            let alert = UIAlertController(title: "", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            let conform = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (_) in
                let userDefaults = UserDefaults()
                userDefaults.set(false, forKey: "isLogin")
                userDefaults.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(conform)
            self.present(alert, animated: true, completion: nil)
        default: return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

