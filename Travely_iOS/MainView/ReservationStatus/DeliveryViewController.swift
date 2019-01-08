//
//  DeliveryViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 09/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class DeliveryViewController: UIViewController {
    
    let titleImageView = UIImageView.init(image: UIImage.init(named: "logoWhite.png"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = titleImageView
    }
    


}
