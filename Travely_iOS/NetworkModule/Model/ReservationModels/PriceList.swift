//
//  PriceList.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 08/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct PriceList: Codable {
    let price : Int?
    let priceIdx : Int?
    
    enum CodingKeys: String, CodingKey {
        case price = "price"
        case priceIdx = "priceIdx"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        priceIdx = try values.decodeIfPresent(Int.self, forKey: .priceIdx)
    }
    
}
