//
//  Date.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 07/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

extension Date {
//    func compareTimeOnly(to: Date) -> ComparisonResult {
//        let calendar = Calendar.current
//        let components2 = calendar.dateComponents([.hour, .minute, .second], from: to)
//        let date3 = calendar.date(bySettingHour: components2.hour!, minute: components2.minute!, second: components2.second!, of: self)!
//        
//        let seconds = calendar.dateComponents([.second], from: self, to: date3).second!
//        if seconds == 0 {
//            return .orderedSame
//        } else if seconds > 0 {
//            // Ascending means before
//            return .orderedAscending
//        } else {
//            // Descending means after
//            return .orderedDescending
//        }
//    }
    
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
