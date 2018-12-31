//
//  StoreDetailModel.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation
struct StoreDetailModel : Codable {
	let storeIdx : Int?
	let ownerIdx : Int?
	let storeName : String?
	let storeCall : String?
	let storeUrl : String?
	let address : String?
	let openTime : String?
	let closeTime : String?
	let latitude : Double?
	let longitude : Double?
	let limit : Int?
	let currentBag : Int?
	let grade : Double?
	let reviewResponseDtos : [ReviewResponseDtos]?
	let storeImageResponseDtos : [StoreImageResponseDtos]?

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
		case currentBag = "currentBag"
		case grade = "grade"
		case reviewResponseDtos = "reviewResponseDtos"
		case storeImageResponseDtos = "storeImageResponseDtos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
		ownerIdx = try values.decodeIfPresent(Int.self, forKey: .ownerIdx)
		storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
		storeCall = try values.decodeIfPresent(String.self, forKey: .storeCall)
		storeUrl = try values.decodeIfPresent(String.self, forKey: .storeUrl)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		openTime = try values.decodeIfPresent(String.self, forKey: .openTime)
		closeTime = try values.decodeIfPresent(String.self, forKey: .closeTime)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		currentBag = try values.decodeIfPresent(Int.self, forKey: .currentBag)
		grade = try values.decodeIfPresent(Double.self, forKey: .grade)
		reviewResponseDtos = try values.decodeIfPresent([ReviewResponseDtos].self, forKey: .reviewResponseDtos)
		storeImageResponseDtos = try values.decodeIfPresent([StoreImageResponseDtos].self, forKey: .storeImageResponseDtos)
	}

}
