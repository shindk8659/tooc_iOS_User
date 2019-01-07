//
//  ReservationStatusViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 01/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import GoogleMaps

class ReservationStatusViewController: UITableViewController {
    
    @IBOutlet var halfBgImage: UIImageView!
    @IBOutlet var reservationView: UIView!
    @IBOutlet var qrCodeView: UIView!
    @IBOutlet var statusProgressView: [UIView]!
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var superViewOfMap: UIView!
    @IBOutlet var qrCode: UIImageView!
    
    @IBAction func didPressRVCancel(_ sender: UIButton) {
        networkManager.cancelReservation { [weak self] (result, errorModel, error) in
            print(result,errorModel,error)
        }
    }
    
    
    lazy var mapView = GMSMapView()
    // mapMarker
    let marker = GMSMarker()
    var initialCheck = 1
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        
        let image = generateQRCode(from: "Hello")
        qrCode.image = image
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    func layoutSetup() {
        halfBgImage.layer.shadowColor = UIColor.black.cgColor
        halfBgImage.layer.shadowRadius = 5
        halfBgImage.layer.shadowOpacity = 0.5
        halfBgImage.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        reservationView.layer.cornerRadius = 20
        reservationView.layer.shadowColor = UIColor.black.cgColor
        reservationView.layer.shadowRadius = 10
        reservationView.layer.shadowOpacity = 0.5
        reservationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        qrCodeView.layer.shadowColor = UIColor.black.cgColor
        qrCodeView.layer.shadowRadius = 5
        qrCodeView.layer.shadowOpacity = 0.5
        qrCodeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        for view in statusProgressView {
            view.layer.borderWidth = 2
            //        view.layer.borderColor = UIColor(displayP3Red: 166, green: 174, blue: 234, alpha: 1).cgColor
            view.layer.borderColor = UIColor(red: 0xA9, green: 0xD2, blue: 0xD5).cgColor
            view.layer.cornerRadius = view.frame.width / 2
        }
        
        cancelButton.layer.borderWidth = 0.5
        cancelButton.layer.borderColor = UIColor(red: 0xB6, green: 0xB6, blue: 0xB6).cgColor
        cancelButton.layer.cornerRadius = cancelButton.frame.width / 13
        
        mapView.isMyLocationEnabled = true
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
    
    override func viewDidLayoutSubviews() {
        if initialCheck == 1 {
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: superViewOfMap.frame.width, height: superViewOfMap.frame.height), camera: GMSCameraPosition.camera(withLatitude: 37.558514, longitude: 126.925239, zoom: 15))
            mapView.settings.setAllGesturesEnabled(false)
        superViewOfMap.addSubview(mapView)
            initialCheck += 1
            //지도 마커
            marker.icon = UIImage(named: "icPinColor.png")
            marker.position = CLLocationCoordinate2D(latitude: 37.558514, longitude: 126.925239)
            marker.map = self.mapView
            mapView.camera = GMSCameraPosition.camera(withTarget: self.marker.position, zoom: 16)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 820 + ((820*self.view.frame.width)/375 - 820)
//        case 1:
//            return 210 + ((210*self.view.frame.width)/375 - 210)
//        case 2:
//            return 350 + ((350*self.view.frame.width)/375 - 350)
//        default: return 0
//        }
//    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
