//
//  cancelConfirmViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 29/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

protocol presentAlert {
    func presentRVAlert()
}

class cancelConfirmViewController: UIViewController {

    @IBOutlet var alertView: UIView!
    
    @IBOutlet var confirmButton: UIButton!
    
    @IBOutlet var closeButton: UIButton!
    
    @IBAction func didPressConfirm(_ sender: UIButton) {
        networkManager.cancelReservation { [weak self] (result, errorModel, error) in
            self!.dismiss(animated: true, completion: nil)
            self?.delegate.presentRVAlert()
        }
    }
    
    @IBAction func didPressClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let networkManager = NetworkManager()
    var delegate: presentAlert!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        //주석
    }
    
    func layoutSetup() {
        alertView.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 18
        closeButton.layer.borderWidth = 2
        closeButton.layer.borderColor = UIColor(red: 0x1F, green: 0xBF, blue: 0xC8).cgColor
        closeButton.layer.cornerRadius = 18
        
    }
    
}
