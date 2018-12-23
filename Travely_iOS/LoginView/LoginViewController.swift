//
//  LoginViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/22/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func loginBtnAct(_ sender: Any) {
    
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstmain") as! UITabBarController
        self.present(mainView, animated: true, completion: nil)
    }
    @IBAction func signupBtnAct(_ sender: Any) {
        
        let signupView = self.storyboard?.instantiateViewController(withIdentifier:"signup") as! SignupViewController
        self.navigationController?.pushViewController(signupView, animated: true)

        
    }
 
}
