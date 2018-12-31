//
//  CircleButton.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 31/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = min(frame.width, frame.height) / 2
        
//        titleLabel?.minimumScaleFactor = 0.5
//        titleLabel?.numberOfLines = 0
//        titleLabel?.adjustsFontSizeToFitWidth = true
    }
}
