//
//  InquiryViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 09/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import Photos
import Alamofire

class InquiryViewController: UIViewController {
    
    var image = UIImage()
    let networkManager = NetworkManager()
    var testText = String()

    @IBOutlet var textView: UITextView!
    @IBOutlet var addImgView: UIView!
    @IBOutlet var imgName: UILabel!
    
    @IBAction func didPressComplete(_ sender: Any) {
//        networkManager.postInquiry(image: <#T##[String]#>, content: <#T##String#>, createAt: <#T##String#>, completion: <#T##(ErrorModel?, ErrorModel?, Error?) -> Void#>)
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
        let imgData1:Data = image.jpegData(compressionQuality: 1)!
        let imgData2:Data = image.pngData()!
//        alarmImgUpload(imgData: imgData!)
        if imgData1 != nil {
            print("데이터 있음")
            print(imgData1)
        }
        
//        networkManager.uploadImg(data: imgData1!) { [weak self](result, errorModel, error) in
//            print("결과 \(result)")
//            print("에러모델 \(errorModel)")
//            print("에러 \(error)")
//        }
//        dismiss(animated: true, completion: nil)
        
        dismiss(animated: true) {
           self.tabBarController?.hideTabBarAnimated(hide: false)
            self.networkManager.uploadImg(data: imgData2) { [weak self](result, errorModel, error) in
                print("결과 \(result)")
                print("에러모델 \(errorModel)")
                print("에러 \(error)")
            }
            self.alarmImgUpload(imgData: imgData2)
        }
    }
    
    func alarmImgUpload(imgData: Data) {
        let jwt = UserDefaults.standard.string(forKey: "jwt")
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let url = "http://52.78.222.197:8080/api/img"
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "image.png", fileName: "image.png", mimeType: "image/png")
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: header) { (result) in
            switch result {
            case .success(let upload, _, _): upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
//            upload.responseJSON(completionHandler: { (response) in
//                if let result = response.result.value {
//                    print(response)
//                    print(result)
//                    print(response.result.value)
//                    print("성공")
//                }
//            })
            upload.responseData(completionHandler: { (data) in
                print(data.response?.statusCode)
                print(data.error, data.result)
                print(data.result.value)
            })
            case .failure(let err): print("error: \(err)")
            }
        }
    }
    
    func imageUpload() {
//        Alamofire.upload(
//            multipartFormData: { MultipartFormData in
//                MultipartFormData.append(UIImage.jpegData(UIImage(named: "reviewIcStar")!), withName: "image.jpeg", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//        }, to: "http://platform.twitone.com/station/add-feedback") { (result) in
//
//            switch result {
//            case .success(let upload, _, _):
//
//                upload.responseJSON { response in
//                    print(response.result.value)
//                }
//
//            case .failure(let encodingError): break
//            print(encodingError)
//            }
//
//
//        }
    }
    
//    func imgUpload(){
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(self.imgData1!, withName: "head_picture", fileName: "my.jpeg", mimeType: "image/jpeg")
//        }, to:"http://*******.200:9999/upload/head-picture.do")
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (Progress) in
//                    picker.dismiss(animated: true, completion: nil)
//                    print("Upload Progress: \(Progress.fractionCompleted)")
//                })
//
//                upload.responseJSON { response in
//                    //self.delegate?.showSuccessAlert()
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)   // result of response serialization
//                    //                        self.showSuccesAlert()
//                    if let JSON = response.result.value {
//                        print("JSON: \(JSON)")
//                    }
//                }
//                self.portraitUIImageView.image = UIImage(data: data!)
//            case .failure(let encodingError):
//                //self.delegate?.showFailAlert()
//                print(encodingError)
//            }
//        }
//    }
    
}
