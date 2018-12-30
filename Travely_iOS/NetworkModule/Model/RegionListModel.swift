//
//  RegionListModel.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation
struct RegionListModel : Codable {
    let regionName : String?
    let cnt : Int?
    let regionIdx : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case regionName = "regionName"
        case cnt = "cnt"
        case regionIdx = "regionIdx"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        regionName = try values.decodeIfPresent(String.self, forKey: .regionName)
        cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
        regionIdx = try values.decodeIfPresent(Int.self, forKey: .regionIdx)
    }
    
}
