//
//  InquiryViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 09/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import Photos

class InquiryViewController: UIViewController {
    
    var image = UIImage()
    let networkManager = NetworkManager()
    var testText = String()
    var imgURL = ""

    @IBOutlet var textView: UITextView!
    @IBOutlet var addImgView: UIView!
    @IBOutlet var imgName: UILabel!
    
    @IBAction func didPressComplete(_ sender: Any) {
        
        if textView.text.isEmpty == true{
            showAlertMessage(titleStr: "", messageStr: "문의하실 내용을 적어주세요.")
        } else {
        
        let text = textView.text ?? "빈 메시지"
            networkManager.postInquiry(image: [imgURL], content: text) { [weak self] (nil, ErrorModel, Error) in
                if ErrorModel == nil && Error != nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
                } else if ErrorModel != nil && Error == nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
                } else {
                    let alert = UIAlertController(title: "", message: "문의가 등록되었습니다.", preferredStyle: .alert)
                    let confirm = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (_) in
                        self?.navigationController?.popViewController(animated: true)
                    })
                    alert.addAction(confirm)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapInside))
        addImgView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func tapInside() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.tabBarController?.hideTabBarAnimated(hide: true)
        present(imagePicker, animated: true, completion: nil)
    }

    func layoutSetup() {
        addImgView.layer.borderWidth = 1
        addImgView.layer.borderColor = UIColor(red: 0xB1, green: 0xB1, blue: 0xB1).cgColor
        addImgView.layer.cornerRadius = 2
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0xB1, green: 0xB1, blue: 0xB1).cgColor
        textView.layer.cornerRadius = 2
    }
}

extension InquiryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.tabBarController?.hideTabBarAnimated(hide: false)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let assetResources = PHAssetResource.assetResources(for: asset)
            imgName.text = assetResources.first?.originalFilename ?? "파일오류"
            testText = (assetResources.first?.originalFilename)!
        }
        
        var newImg = UIImage()
        
        if let possibleImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImg = possibleImg
        }
        else if let possibleImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImg = possibleImg
        }
        else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        image = newImg
        let imgData:Data = image.jpegData(compressionQuality: 1)!
        
        networkManager.uploadImg(data: imgData) { [weak self](result, errorModel, error) in
            if result == nil && errorModel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
            } else if result == nil && errorModel != nil && error == nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
            } else {
                self?.imgURL = result?.bagImgUrl ?? ""
            }
        }
        
        dismiss(animated: true) {
            self.tabBarController?.hideTabBarAnimated(hide: false)
        }
    }
}
