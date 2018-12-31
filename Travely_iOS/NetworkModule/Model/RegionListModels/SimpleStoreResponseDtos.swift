//
//  SimpleStoreResponseDtos.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/30/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation
struct SimpleStoreResponseDtos : Codable {
    let storeIdx : Int?
    let storeName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case storeIdx = "storeIdx"
        case storeName = "storeName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
    }
    
}
