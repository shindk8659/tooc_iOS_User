//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct MyReviewModel : Codable {
	let reviewIdx : Int?
	let content : String?
	let liked : Int?
	let createAt : Int?
	let storeIdx : Int?
	let ownerIdx : Int?
	let storeName : String?
	let regionIdx : Int?
	let storeCall : String?
	let storeUrl : String?
	let address : String?
	let openTime : Int?
	let closeTime : Int?
	let latitude : Double?
	let longitude : Double?
	let limit : Int?
	let storeImgUrl : String?

	enum CodingKeys: String, CodingKey {

		case reviewIdx = "reviewIdx"
		case content = "content"
		case liked = "liked"
		case createAt = "createAt"
		case storeIdx = "storeIdx"
		case ownerIdx = "ownerIdx"
		case storeName = "storeName"
		case regionIdx = "regionIdx"
		case storeCall = "storeCall"
		case storeUrl = "storeUrl"
		case address = "address"
		case openTime = "openTime"
		case closeTime = "closeTime"
		case latitude = "latitude"
		case longitude = "longitude"
		case limit = "limit"
		case storeImgUrl = "storeImgUrl"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		reviewIdx = try values.decodeIfPresent(Int.self, forKey: .reviewIdx)
		content = try values.decodeIfPresent(String.self, forKey: .content)
		liked = try values.decodeIfPresent(Int.self, forKey: .liked)
		createAt = try values.decodeIfPresent(Int.self, forKey: .createAt)
		storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
		ownerIdx = try values.decodeIfPresent(Int.self, forKey: .ownerIdx)
		storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
		regionIdx = try values.decodeIfPresent(Int.self, forKey: .regionIdx)
		storeCall = try values.decodeIfPresent(String.self, forKey: .storeCall)
		storeUrl = try values.decodeIfPresent(String.self, forKey: .storeUrl)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		openTime = try values.decodeIfPresent(Int.self, forKey: .openTime)
		closeTime = try values.decodeIfPresent(Int.self, forKey: .closeTime)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		storeImgUrl = try values.decodeIfPresent(String.self, forKey: .storeImgUrl)
	}

}
