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
    
    
    
    
    
    
    
    

    // MARK: - Table view data source

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
