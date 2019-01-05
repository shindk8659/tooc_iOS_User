//
//  SignupViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/22/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var configPassTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    let networkManager = NetworkManager()
    let userdata = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAddtarget()
        if userdata.string(forKey: "showGuide") == nil {
            userdata.setValue("yes", forKey: "showGuide")
            userdata.synchronize()
        }
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
       
        if nameTextField.text == "" || emailTextField.text == "" || phoneTextField.text == "" || configPassTextField.text == "" || passTextField.text == "" {

            let alertController = UIAlertController(title: "",message: "정보를 입력 해 주세요", preferredStyle: UIAlertController.Style.alert)
            let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(cancelButton)
            self.present(alertController,animated: true,completion: nil)
        }

        else {

            networkManager.signin(email: gsno(emailTextField.text), password: gsno(passTextField.text), configPassword: gsno(configPassTextField.text), name: gsno(nameTextField.text), phone: gsno(phoneTextField.text)) { [weak self](signin, errorModel, error) in

                // 로그인 네트워크 처리
                if signin == nil && errorModel == nil && error != nil {
                    let alertController = UIAlertController(title: "",message: "네트워크 오류입니다.", preferredStyle: UIAlertController.Style.alert)
                    let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    alertController.addAction(cancelButton)
                    self?.present(alertController,animated: true,completion: nil)
                }
                else if signin == nil && errorModel != nil && error == nil {
                    let alertController = UIAlertController(title: "",message: "정확한 정보를 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
                    let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    alertController.addAction(cancelButton)
                    self?.present(alertController,animated: true,completion: nil)
                }
                else {
                    if self?.userdata.string(forKey: "showGuide") == "yes" {
                        self?.userdata.setValue("no", forKey: "showGuide")
                        self?.userdata.synchronize()

                        let guideView = UIStoryboard(name: "LoginSignup", bundle: nil).instantiateViewController(withIdentifier: "appguideview") as! UINavigationController
                        self?.present(guideView, animated: true, completion: nil)
                        
                    }
                    else {
                        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstmain") as! UITabBarController
                        self?.present(mainView, animated: true, completion: nil)
                        
                    }
                    
                }
            }
        }
    }
    
    func initAddtarget(){
        nameTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        configPassTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        passTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
    }
    
    @objc func isValid(){
        
        if nameTextField.text == "" || emailTextField.text == "" || phoneTextField.text == "" || configPassTextField.text == "" || passTextField.text == ""{
            
            let image = UIImage(named: "btSignin.png") as UIImage?
            confirmButton.setImage(image, for: .normal)
        }
        else {
            let image = UIImage(named: "btSignok.png") as UIImage?
            confirmButton.setImage(image, for: .normal)
        }
    }

}
