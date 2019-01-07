//
//  TestViewController5.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 29/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit
import GoogleMaps

class TestViewController5: UIViewController {

    @IBOutlet var testImageView: UIImageView!
    
    @IBAction func presentAlert(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CancelAlertViewController") as! CancelAlertViewController
        self.present(vc, animated: true, completion: nil)
    }
    
//        lazy var mapView = GMSMapView.map(withFrame: CGRect(x: 20, y: 20, width: 340, height: 160), camera: GMSCameraPosition.camera(withLatitude: 37.558514, longitude: 126.925239, zoom: 15))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapView.isMyLocationEnabled = true
//        self.view.addSubview(mapView)
        //주석
        
        let image = generateQRCode(from: "Hello")
        
        testImageView.image = image
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}
