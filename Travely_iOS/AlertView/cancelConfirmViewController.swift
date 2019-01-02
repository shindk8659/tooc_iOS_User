//
//  cancelConfirmViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 29/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class cancelConfirmViewController: UIViewController {

    @IBOutlet var alertView: UIView!
    
    @IBOutlet var confirmButton: UIButton!
    
    @IBOutlet var closeButton: UIButton!
    
    @IBAction func didPressConfirm(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        //주석
    }
    
    func layoutSetup() {
        alertView.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 18
        closeButton.layer.cornerRadius = 18
    }
    

    
}