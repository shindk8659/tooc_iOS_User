//
//  SetFavoriteModel.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/7/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct SetFavoriteModel : Codable {
    let userIdx : Int?
    let storeIdx : Int?
    let isFavorite : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case userIdx = "userIdx"
        case storeIdx = "storeIdx"
        case isFavorite = "isFavorite"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
        isFavorite = try values.decodeIfPresent(Int.self, forKey: .isFavorite)
    }
    
}

