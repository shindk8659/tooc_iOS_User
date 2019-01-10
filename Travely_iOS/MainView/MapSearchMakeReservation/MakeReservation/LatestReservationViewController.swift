//
//  LatestReservationViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 02/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import GoogleMaps

class LatestReservationViewController: UITableViewController {
    
    @IBOutlet var halfBgImage: UIImageView!
    @IBOutlet var reservationView: UIView!
    @IBOutlet var superViewOfMap: UIView!
    
    lazy var mapView = GMSMapView()
    var initialCheck = 1
    // titleImage
    let titleImageView = UIImageView.init(image: UIImage.init(named: "logoWhite.png"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
         self.navigationItem.titleView = titleImageView
    }
    
    func layoutSetup() {
        halfBgImage.layer.shadowColor = UIColor.black.cgColor
        halfBgImage.layer.shadowRadius = 5
        halfBgImage.layer.shadowOpacity = 0.5
        halfBgImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        reservationView.layer.cornerRadius = 20
        reservationView.layer.shadowColor = UIColor.black.cgColor
        reservationView.layer.shadowRadius = 10
        reservationView.layer.shadowOpacity = 0.5
        reservationView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    override func viewDidLayoutSubviews() {
        if initialCheck == 1 {
            mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: superViewOfMap.frame.width, height: superViewOfMap.frame.height), camera: GMSCameraPosition.camera(withLatitude: 37.558514, longitude: 126.925239, zoom: 15))
            superViewOfMap.addSubview(mapView)
            initialCheck += 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
