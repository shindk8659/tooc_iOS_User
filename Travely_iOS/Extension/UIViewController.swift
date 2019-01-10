//
//  UIViewController.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 10/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertMessage(titleStr:String?, messageStr:String?) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
