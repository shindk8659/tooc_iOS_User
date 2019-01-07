//
//  MainTabBarController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 07/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var isReserve: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        if isReserve == true {
            let ReservationStatusViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReservationStatusNavi") 
            
            ReservationStatusViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_reservation_gray_tab"),tag: 1)
            
            ReservationStatusViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            self.viewControllers![1] = ReservationStatusViewController
            self.selectedIndex = 1
        } 
    }
}
