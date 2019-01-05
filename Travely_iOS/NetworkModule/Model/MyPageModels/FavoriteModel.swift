//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct FavoriteModel : Codable {
	let regionName : String?
	let regionIdx : Int?
	let simpleStoreResponseDtos : [SimpleStoreResponseDtos]?

	enum CodingKeys: String, CodingKey {

		case regionName = "regionName"
		case regionIdx = "regionIdx"
		case simpleStoreResponseDtos = "simpleStoreResponseDtos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		regionName = try values.decodeIfPresent(String.self, forKey: .regionName)
		regionIdx = try values.decodeIfPresent(Int.self, forKey: .regionIdx)
		simpleStoreResponseDtos = try values.decodeIfPresent([SimpleStoreResponseDtos].self, forKey: .simpleStoreResponseDtos)
	}

}
