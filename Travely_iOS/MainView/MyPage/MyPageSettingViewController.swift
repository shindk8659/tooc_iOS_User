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
        case 6:
            let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "termofservice") as! WholeTermTableViewController
            VC.addBackButton("black")
            self.navigationController?.pushViewController(VC, animated: true)
        default: return
        }
    }
    
}

