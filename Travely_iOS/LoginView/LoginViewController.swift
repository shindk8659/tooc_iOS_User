//
//  LoginViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/22/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let networkManager = NetworkManager()
    let userDefaults = UserDefaults.standard
    var isReserve: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바를 투명하게 
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        emailTextField.keyboardType = .asciiCapable
        passwordTextField.keyboardType = .asciiCapable
       
        // Do any additional setup after loading the view.
        if self.userDefaults.bool(forKey: "isLogin") == true {
            let email = self.userDefaults.string(forKey: "email")
            let password = self.userDefaults.string(forKey: "pass")
            
            networkManager.login(email: email! , password: password!) { [weak self](login,errorModel,error) in
                if login == nil && errorModel == nil && error != nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
                } else {
                    self?.userDefaults.set(email, forKey: "email")
                    self?.userDefaults.set(password, forKey: "pass")
                    self?.userDefaults.set(true, forKey: "isLogin")
                    let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstmain") as! MainTabBarController
                    mainView.isReserve = login?.isReserve
                    if mainView.isReserve != nil{
                    self?.present(mainView, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    

    
    
    
    @IBAction func loginBtnAct(_ sender: Any) {
    
        if emailTextField.text == "" || passwordTextField.text ==  "" {
            if emailTextField.text == ""{
                 self.showAlertMessage(titleStr:"", messageStr: "이메일을 입력해주세요.")
                
            } else{
                self.showAlertMessage(titleStr:"", messageStr: "비밀번호를 입력해주세요.")
            }
        }
        else {
            networkManager.login(email: gsno(emailTextField.text), password: gsno(passwordTextField.text)) { [weak self](login,errorModel,error) in
              
                // 로그인 네트워크 처리
                if login == nil && errorModel == nil && error != nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
                }
                else if login == nil && errorModel != nil && error == nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "이메일과 비밀번호를 확인해주세요.")
                }
                else {
                    self?.userDefaults.set(self?.emailTextField.text, forKey: "email")
                    self?.userDefaults.set(self?.passwordTextField.text, forKey: "pass")
                    self?.userDefaults.set(true, forKey: "isLogin")
                    self?.emailTextField.text = ""
                    self?.passwordTextField.text = ""
                    let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstmain") as! MainTabBarController
                    mainView.isReserve = login?.isReserve
                    self?.present(mainView, animated: true, completion: nil)
                    let guideView = UIStoryboard(name: "LoginSignup", bundle: nil).instantiateViewController(withIdentifier: "appguideview") as!UINavigationController
                    self?.present(guideView, animated: true, completion: nil)
                }
            }
        }
        
      
    }
    @IBAction func signupBtnAct(_ sender: Any) {
        let signupView = self.storyboard?.instantiateViewController(withIdentifier:"signup") as! SignupViewController
        self.navigationController?.pushViewController(signupView, animated: true)
    }
}

