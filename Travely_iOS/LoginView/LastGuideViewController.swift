//
//  LastGuideViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/6/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class LastGuideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstmain") as! UITabBarController
        self.present(mainView, animated: true, completion: nil)
    }
    

}
