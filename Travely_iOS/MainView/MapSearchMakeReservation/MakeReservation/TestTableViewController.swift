//
//  TestTableViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 28/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit
import GoogleMaps

class TestTableViewController: UITableViewController {
    
    var carrierCheck = false
    var loadCheck = false {
        didSet {
//            if loadCheck {
//                topConst.constant = 0
//            } else {
//                topConst.constant = 24
//            }
            //주석
        }
    }
    
    @IBOutlet var testView: UIView!
    lazy var mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: testView.frame.width, height: testView.frame.height), camera: GMSCameraPosition.camera(withLatitude: 37.558514, longitude: 126.925239, zoom: 15))
    
    
    var test = false

    @IBOutlet var cell1: UITableViewCell!
    
    @IBAction func didPressCheck(_ sender: UIButton) {
        if sender.tag == 0 {
            if carrierCheck == false {
                carrierCheck = !carrierCheck
                sender.setImage(UIImage(named: "checkbox_fill"), for: .normal)
                
                tableView.reloadData()
            } else {
                carrierCheck = !carrierCheck
                sender.setImage(UIImage(named: "checkbox_empty"), for: .normal)
                
                tableView.reloadData()
            }
        } else {
            if loadCheck == false {
                loadCheck = !loadCheck
                sender.setImage(UIImage(named: "checkbox_fill"), for: .normal)
                
                tableView.reloadData()
            } else {
                loadCheck = !loadCheck
                sender.setImage(UIImage(named: "checkbox_empty"), for: .normal)
                
                tableView.reloadData()
            }
            
        }
        
    }
    
    @IBAction func test1(_ sender: Any) {
//        self.tableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.none)
//        cell1.isHidden = true
        if test {
        test = !test
        tableView.reloadData()
        } else {
        test = !test
        tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCheck = false
        mapView.isMyLocationEnabled = true
        testView.addSubview(mapView)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 1 && carrierCheck == true {
//            print("실행1")
//            return UITableView.automaticDimension
//        } else if indexPath.row == 1 && carrierCheck == false {
//            return 0
//        }
//        
//        if indexPath.row == 3 && loadCheck == true {
//            print("실행2")
//            return UITableView.automaticDimension
//        }else if indexPath.row == 3 && loadCheck == false {
//            return 0
//        }
//        
//        if indexPath.row == 4 && (carrierCheck == true || loadCheck == true) {
//            return 44
//        } else if indexPath.row == 4 {
//            return 0
//        }
//        
//        return UITableView.automaticDimension
//    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        if section == 0 {
//            if test == true {
//                return 2
//            } else {
//                return 1
//            }
//        } else {
//            return 3
//        }
//    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//        if indexPath.row == 0 {
//            return cell1
//        } else {
//            let cell = UITableViewCell()
//            cell.backgroundColor = .blue
//            return cell
//        }
//        } else {
//            let cell = UITableViewCell()
//            cell.backgroundColor = .black
//            return cell
//        }
//    }
 

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
