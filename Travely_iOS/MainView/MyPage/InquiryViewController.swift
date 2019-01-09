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
    
    @objc func tapInside() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
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
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let assetResources = PHAssetResource.assetResources(for: asset)
            imgName.text = assetResources.first?.originalFilename ?? "파일오류"
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
        let imgData = image.jpegData(compressionQuality: 1)
        alarmImgUpload(imgData: imgData!)
        dismiss(animated: true, completion: nil)
    }
    
    func alarmImgUpload(imgData: Data) {
        let jwt = UserDefaults.standard.string(forKey: "jwt")
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let url = "http://52.78.222.197:8080/api/img"
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "fileset", fileName: "file.jpg", mimeType: "image/jpg")
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: header) { (result) in
            switch result {
            case .success(let upload, _, _): upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            upload.responseJSON(completionHandler: { (response) in
                if let result = response.result.value {
                    print(response)
                    print(result)
                    print(response.result.value)
                    print("성공")
                }
            })
            case .failure(let err): print("error: \(err)")
            }
        }
    }
}
