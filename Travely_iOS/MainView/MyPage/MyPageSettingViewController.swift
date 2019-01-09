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
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            let VC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "aboutTooc")
            VC.addBackButton("black")
            self.navigationController?.pushViewController(VC, animated: true)
        case 3: return
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

