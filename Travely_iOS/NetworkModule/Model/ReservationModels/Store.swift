//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct Store : Codable {
	let address : String?
	let addressNumber : String?
	let avgLike : Int?
	let closeTime : CloseTime?
	let latitude : Int?
	let longitude : Int?
	let openTime : OpenTime?
	let ownerName : String?
	let storeCall : String?
	let storeIdx : Int?
	let storeName : String?

	enum CodingKeys: String, CodingKey {

		case address = "address"
		case addressNumber = "addressNumber"
		case avgLike = "avgLike"
		case closeTime = "closeTime"
		case latitude = "latitude"
		case longitude = "longitude"
		case openTime = "openTime"
		case ownerName = "ownerName"
		case storeCall = "storeCall"
		case storeIdx = "storeIdx"
		case storeName = "storeName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		addressNumber = try values.decodeIfPresent(String.self, forKey: .addressNumber)
		avgLike = try values.decodeIfPresent(Int.self, forKey: .avgLike)
		closeTime = try values.decodeIfPresent(CloseTime.self, forKey: .closeTime)
		latitude = try values.decodeIfPresent(Int.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Int.self, forKey: .longitude)
		openTime = try values.decodeIfPresent(OpenTime.self, forKey: .openTime)
		ownerName = try values.decodeIfPresent(String.self, forKey: .ownerName)
		storeCall = try values.decodeIfPresent(String.self, forKey: .storeCall)
		storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
		storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
	}

}
