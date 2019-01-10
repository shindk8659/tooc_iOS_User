//
//  TESTViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 10/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import Lottie

class TESTViewController: UIViewController {

    @IBOutlet var testlot: LOTAnimatedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testlot.animationView.setAnimation(named: "tooc_IOS")
        testlot.animationView.play { [weak self](true) in
            let loginView = UIStoryboard.init(name: "LoginSignup", bundle: nil).instantiateViewController(withIdentifier: "loginnavi")
            self?.present(loginView, animated: false, completion: nil)
        }
    }
}
