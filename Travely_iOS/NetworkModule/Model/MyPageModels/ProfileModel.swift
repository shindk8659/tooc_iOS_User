//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct ProfileModel: Codable {
	let userIdx : Int?
	let email : String?
	let name : String?
	let phone : String?
	let profileImg : String?
	let reviewCount : Int?
	let favoriteCount : Int?
	let myBagCount : Int?
	let storeInfoResponseDtoList : [StoreInfoResponseDtoList]?

	enum CodingKeys: String, CodingKey {

		case userIdx = "userIdx"
		case email = "email"
		case name = "name"
		case phone = "phone"
		case profileImg = "profileImg"
		case reviewCount = "reviewCount"
		case favoriteCount = "favoriteCount"
		case myBagCount = "myBagCount"
		case storeInfoResponseDtoList = "storeInfoResponseDtoList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		profileImg = try values.decodeIfPresent(String.self, forKey: .profileImg)
		reviewCount = try values.decodeIfPresent(Int.self, forKey: .reviewCount)
		favoriteCount = try values.decodeIfPresent(Int.self, forKey: .favoriteCount)
		myBagCount = try values.decodeIfPresent(Int.self, forKey: .myBagCount)
		storeInfoResponseDtoList = try values.decodeIfPresent([StoreInfoResponseDtoList].self, forKey: .storeInfoResponseDtoList)
	}

}
