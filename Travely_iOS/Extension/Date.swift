//
//  Date.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 07/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

extension Date {
    func isDateAvailable(openTime: Date, closeTime: Date ) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
    
        if Int(dateFormatter.string(from: self))! > Int(dateFormatter.string(from: openTime))! && Int(dateFormatter.string(from: self))! < Int(dateFormatter.string(from: closeTime))! {
            return true
        } else {
            return false
        }
    }
}
