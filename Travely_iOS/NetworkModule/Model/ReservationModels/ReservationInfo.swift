//
//  ReservationInfo.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 08/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct ReservationInfo: Codable {
    let bagDtos : [BagDtos]?
    let bagImgDtos : [BagImgDtos]?
    let depositTime : Int?
    let endTime : Int?
    let extraCharge : Int?
    let extraChargeCount : Int?
    let payType : String?
    let price : Int?
    let priceIdx : Int?
    let priceUnit : Int?
    let progressType : String?
    let reserveCode : String?
    let startTime : Int?
    let stateType : String?
    let store : Store?
    let takeTime : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case bagDtos = "bagDtos"
        case bagImgDtos = "bagImgDtos"
        case depositTime = "depositTime"
        case endTime = "endTime"
        case extraCharge = "extraCharge"
        case extraChargeCount = "extraChargeCount"
        case payType = "payType"
        case price = "price"
        case priceIdx = "priceIdx"
        case priceUnit = "priceUnit"
        case progressType = "progressType"
        case reserveCode = "reserveCode"
        case startTime = "startTime"
        case stateType = "stateType"
        case store = "store"
        case takeTime = "takeTime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bagDtos = try values.decodeIfPresent([BagDtos].self, forKey: .bagDtos)
        bagImgDtos = try values.decodeIfPresent([BagImgDtos].self, forKey: .bagImgDtos)
        depositTime = try values.decodeIfPresent(Int.self, forKey: .depositTime)
        endTime = try values.decodeIfPresent(Int.self, forKey: .endTime)
        extraCharge = try values.decodeIfPresent(Int.self, forKey: .extraCharge)
        extraChargeCount = try values.decodeIfPresent(Int.self, forKey: .extraChargeCount)
        payType = try values.decodeIfPresent(String.self, forKey: .payType)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        priceIdx = try values.decodeIfPresent(Int.self, forKey: .priceIdx)
        priceUnit = try values.decodeIfPresent(Int.self, forKey: .priceUnit)
        progressType = try values.decodeIfPresent(String.self, forKey: .progressType)
        reserveCode = try values.decodeIfPresent(String.self, forKey: .reserveCode)
        startTime = try values.decodeIfPresent(Int.self, forKey: .startTime)
        stateType = try values.decodeIfPresent(String.self, forKey: .stateType)
        store = try values.decodeIfPresent(Store.self, forKey: .store)
        takeTime = try values.decodeIfPresent(Int.self, forKey: .takeTime)
    }
}
