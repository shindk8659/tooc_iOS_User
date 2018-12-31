//
//  CancelAlertViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 29/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class CancelAlertViewController: UIViewController {

    @IBOutlet var alertView: UIView!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var confirmButton: UIButton!

    
    @IBAction func didPressConfirm(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("프레즌트")
            //주석
//            let storyboard = UIStoryboard(name: "Alert", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "cancelConfirmViewController") as! cancelConfirmViewController
//            self.presentingViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
    }
    
    func layoutSetup() {
        alertView.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 18
    }

}
