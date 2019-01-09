//
//  UIAlertController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 10/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

extension UIAlertController {
    func showAlert(title: String?, message: String?) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(cancelButton)
        return alertController
    }
}
