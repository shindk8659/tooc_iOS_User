//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct ReservationModel: Codable {
	let bagDtos : [BagDtos]?
	let endTime : Int?
	let payType : String?
	let price : Int?
	let reserveCode : String?
	let startTime : Int?
	let stateType : String?
	let store : Store?

	enum CodingKeys: String, CodingKey {
		case bagDtos = "bagDtos"
		case endTime = "endTime"
		case payType = "payType"
		case price = "price"
		case reserveCode = "reserveCode"
		case startTime = "startTime"
		case stateType = "stateType"
		case store = "store"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bagDtos = try values.decodeIfPresent([BagDtos].self, forKey: .bagDtos)
        endTime = try values.decodeIfPresent(Int.self, forKey: .endTime)
		payType = try values.decodeIfPresent(String.self, forKey: .payType)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
		reserveCode = try values.decodeIfPresent(String.self, forKey: .reserveCode)
        startTime = try values.decodeIfPresent(Int.self, forKey: .startTime)
		stateType = try values.decodeIfPresent(String.self, forKey: .stateType)
		store = try values.decodeIfPresent(Store.self, forKey: .store)
	}

}
