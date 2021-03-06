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
        self.addBackButton("black")
        initAddtarget()
        if userdata.string(forKey: "showGuide") == nil {
            userdata.setValue("yes", forKey: "showGuide")
            userdata.synchronize()
        }
        nameTextField.keyboardType = .namePhonePad
        emailTextField.keyboardType = .asciiCapable
        phoneTextField.keyboardType = .numberPad
        configPassTextField.keyboardType = .asciiCapable
        passTextField.keyboardType = .asciiCapable
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
       
        if nameTextField.text == "" || emailTextField.text == "" || phoneTextField.text == "" || configPassTextField.text == "" || passTextField.text == "" {

            self.showAlertMessage(titleStr:"", messageStr: "정보를 입력해 주세요.")
        }

        else {

            networkManager.signin(email: gsno(emailTextField.text), password: gsno(passTextField.text), configPassword: gsno(configPassTextField.text), name: gsno(nameTextField.text), phone: gsno(phoneTextField.text)) { [weak self](signin, errorModel, error) in

                // 로그인 네트워크 처리
                if signin == nil && errorModel == nil && error != nil {
                    self?.phoneTextField.text = ""
                    self?.passTextField.text = ""
                    self?.configPassTextField.text = ""
                    self?.emailTextField.text = ""
                    self?.nameTextField.text = ""
                    let image = UIImage(named: "btSignin.png") as UIImage?
                    self?.confirmButton.setImage(image, for: .normal)
                    self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
                }
                else if signin == nil && errorModel != nil && error == nil {
                    var message :String? = ""
                    let image = UIImage(named: "btSignin.png") as UIImage?
                    self?.confirmButton.setImage(image, for: .normal)
                    for i in 0 ..< errorModel!.count
                    {
                        if (errorModel?[i]?.message)! == "잘못된 전화번호 형식입니다." {
                            self?.phoneTextField.text = ""
                        }
                        else if (errorModel?[i]?.message)! == "password형식이 올바르지 않습니다." {
                            self?.passTextField.text = ""
                            self?.configPassTextField.text = ""
                        }
                        else if (errorModel?[i]?.message)! == "비밀번호 확인 비밀번호가 일치하지 않습니다." {
                            self?.configPassTextField.text = ""
                        }
                        else {
                            self?.emailTextField.text = ""
                        }
                        message?.append((errorModel?[i]?.message)!+"\n")
                    }
                    
                    self?.showAlertMessage(titleStr:"정확한 정보를 입력해주세요.", messageStr: message)
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
