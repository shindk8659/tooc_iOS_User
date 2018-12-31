//
//  RegionListModel.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation
struct RegionListModel : Codable {
    let regionIdx : Int?
    let regionName : String?
    let simpleStoreResponseDtos : [SimpleStoreResponseDtos]?
    
    enum CodingKeys: String, CodingKey {
        
        case regionIdx = "regionIdx"
        case regionName = "regionName"
        case simpleStoreResponseDtos = "simpleStoreResponseDtos"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        regionIdx = try values.decodeIfPresent(Int.self, forKey: .regionIdx)
        regionName = try values.decodeIfPresent(String.self, forKey: .regionName)
        simpleStoreResponseDtos = try values.decodeIfPresent([SimpleStoreResponseDtos].self, forKey: .simpleStoreResponseDtos)
    }
    
}
