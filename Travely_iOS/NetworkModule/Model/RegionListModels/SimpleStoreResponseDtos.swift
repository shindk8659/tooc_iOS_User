//
//  SimpleStoreResponseDtos.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/30/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation
struct SimpleStoreResponseDtos: Codable {
    let storeIdx : Int?
    let storeName : String?
    let address : String?
    let openTime : Int?
    let closeTime : Int?
    let grade : Double?
    let storeImgUrl : String?
    
    enum CodingKeys: String, CodingKey {
        
        case storeIdx = "storeIdx"
        case storeName = "storeName"
        case address = "address"
        case openTime = "openTime"
        case closeTime = "closeTime"
        case grade = "grade"
        case storeImgUrl = "storeImgUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        openTime = try values.decodeIfPresent(Int.self, forKey: .openTime)
        closeTime = try values.decodeIfPresent(Int.self, forKey: .closeTime)
        grade = try values.decodeIfPresent(Double.self, forKey: .grade)
        storeImgUrl = try values.decodeIfPresent(String.self, forKey: .storeImgUrl)
    }
    
}
