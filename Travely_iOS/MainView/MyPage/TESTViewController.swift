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
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
