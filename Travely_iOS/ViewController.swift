//
//  ViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/23/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    override func loadView() {
        // 구글지도
        let lat: CLLocationDegrees = 37.558514
        let long: CLLocationDegrees = 126.925239


        let pos = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15)
        //        let mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: pos)
        mapView.isMyLocationEnabled = true
        view = mapView

        // 구글지도 마커 표시
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "홍대입구 근처~~"
        marker.map = mapView
    }
}

