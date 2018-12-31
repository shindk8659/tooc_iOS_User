//
//  StoreImageResponseDtos.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//
import Foundation
struct StoreImageResponseDtos : Codable {
	let storeImgIdx : Int?
	let storeImg : String?

	enum CodingKeys: String, CodingKey {

		case storeImgIdx = "storeImgIdx"
		case storeImg = "storeImg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		storeImgIdx = try values.decodeIfPresent(Int.self, forKey: .storeImgIdx)
		storeImg = try values.decodeIfPresent(String.self, forKey: .storeImg)
	}

}
