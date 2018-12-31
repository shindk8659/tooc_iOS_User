//
//  StoreListModel.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/30/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation
struct StoreListModel : Codable {
    let storeName : String?
    let storeIdx : Int?
    let regionName : String?
    let regionIdx : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case storeName = "storeName"
        case storeIdx = "storeIdx"
        case regionName = "regionName"
        case regionIdx = "regionIdx"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
        regionName = try values.decodeIfPresent(String.self, forKey: .regionName)
        regionIdx = try values.decodeIfPresent(Int.self, forKey: .regionIdx)
    }
    
}
