//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct BagDtos : Codable {
	let bagType : String?
	let bagCount : Int?

	enum CodingKeys: String, CodingKey {

		case bagType = "bagType"
		case bagCount = "bagCount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bagType = try values.decodeIfPresent(String.self, forKey: .bagType)
		bagCount = try values.decodeIfPresent(Int.self, forKey: .bagCount)
	}
}
