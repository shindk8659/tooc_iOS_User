//
//  TestViewController5.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 29/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class TestViewController5: UIViewController {

    @IBAction func presentAlert(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CancelAlertViewController") as! CancelAlertViewController
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //주석
        
    }

}
