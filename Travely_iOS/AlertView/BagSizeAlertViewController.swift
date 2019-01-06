//
//  BagSizeAlertViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 06/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class BagSizeAlertViewController: UIViewController {

    @IBOutlet var popupView: UIView!
    
    @IBAction func didPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
    }
    
    func layoutSetup() {
        popupView.layer.cornerRadius = 10
        popupView.clipsToBounds = true
    }
    

}
