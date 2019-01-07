//
//  BagImgDtos.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 08/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct BagImgDtos: Codable {
    let bagImgUrl : String?
    enum CodingKeys: String, CodingKey {
        case bagImgUrl = "bagImgUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bagImgUrl = try values.decodeIfPresent(String.self, forKey: .bagImgUrl)
    }
}
