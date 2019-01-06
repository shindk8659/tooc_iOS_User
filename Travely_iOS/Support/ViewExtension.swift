//
//  ViewExtension.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/23/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

extension UIImageView {
    func imageFromUrl(_ urlString: String?) {
        if let url = urlString {
            if url.isEmpty {
                self.image = nil
            } else {
                self.kf.setImage(with: URL(string: url), placeholder: nil, options: [.transition(ImageTransition.fade(0.5))])
            }
        } else {
            self.image = nil
        }
    }
}


extension UITabBarController {
    func hideTabBarAnimated(hide:Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            if hide {
                self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            } else {
                self.tabBar.transform = CGAffineTransform.identity
            }
        })
    }
}
extension UINavigationBar {
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}

extension UIViewController {
    
    
    //옵셔널 String을 해제하는데 값이 nil이면 ""을 반환
    func gsno(_ data: String?) -> String {
        guard let str = data else {
            return ""
        }
        return str
    }
    
    //옵셔널 Int를 해제하는데 값이 nil이면 0을 반환
    func gino(_ data: Int?) -> Int {
        guard let num = data else {
            return 0
        }
        return num
    }
    //옵셔널 Double를 해제하는데 값이 nil이면 0을 반환
    func gdno(_ data: Double?) -> Double {
        guard let num = data else {
            return 0
        }
        return num
    }
    func addBackButton(_ pngcolor:String?) {
        
        var image:UIImage
        if pngcolor == "white" {
            image  = UIImage(named: "icBackReservation.png")!
            self.navigationController?.navigationBar.tintColor = UIColor.white
        }
        else {
            image = UIImage(named: "icBack.png")!
            self.navigationController?.navigationBar.tintColor = UIColor.black
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: image, style: .done, target: self, action: #selector(backButtonClick(sender:)))
    }
    
    @objc func backButtonClick(sender : UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true);
    }
}

extension NetworkManager {
    //옵셔널 String을 해제하는데 값이 nil이면 ""을 반환
    func gsno(_ data: String?) -> String {
        guard let str = data else {
            return ""
        }
        return str
    }
    
    //옵셔널 Int를 해제하는데 값이 nil이면 0을 반환
    func gino(_ data: Int?) -> Int {
        guard let num = data else {
            return 0
        }
        return num
    }
    
}
