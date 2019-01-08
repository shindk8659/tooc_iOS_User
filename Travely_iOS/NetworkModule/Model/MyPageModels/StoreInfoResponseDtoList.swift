//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct StoreInfoResponseDtoList : Codable {
	let storeIdx : Int?
	let ownerIdx : Int?
	let storeName : String?
	let storeCall : String?
	let storeUrl : String?
	let address : String?
	let openTime : Int?
	let closeTime : Int?
	let latitude : Double?
	let longitude : Double?
	let limit : Int?
	let storeImage : String?
    let currentBag: Int?
    let available: Int?
    let restWeekResponseDtos : [RestWeekResponseDtos]?

	enum CodingKeys: String, CodingKey {

		case storeIdx = "storeIdx"
		case ownerIdx = "ownerIdx"
		case storeName = "storeName"
		case storeCall = "storeCall"
		case storeUrl = "storeUrl"
		case address = "address"
		case openTime = "openTime"
		case closeTime = "closeTime"
		case latitude = "latitude"
		case longitude = "longitude"
		case limit = "limit"
		case storeImage = "storeImage"
        case currentBag = "currentBag"
        case available = "available"
        case restWeekResponseDtos = "restWeekResponseDtos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
		ownerIdx = try values.decodeIfPresent(Int.self, forKey: .ownerIdx)
		storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
		storeCall = try values.decodeIfPresent(String.self, forKey: .storeCall)
		storeUrl = try values.decodeIfPresent(String.self, forKey: .storeUrl)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		openTime = try values.decodeIfPresent(Int.self, forKey: .openTime)
		closeTime = try values.decodeIfPresent(Int.self, forKey: .closeTime)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		storeImage = try values.decodeIfPresent(String.self, forKey: .storeImage)
        currentBag = try values.decodeIfPresent(Int.self, forKey: .currentBag)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        restWeekResponseDtos = try values.decodeIfPresent([RestWeekResponseDtos].self, forKey: .restWeekResponseDtos)
	}

}
