//
//  FavoriteStoreViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/4/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct EndTime : Codable {
	let date : Int?
	let day : Int?
	let hours : Int?
	let minutes : Int?
	let month : Int?
	let nanos : Int?
	let seconds : Int?
	let time : Int?
	let timezoneOffset : Int?
	let year : Int?

	enum CodingKeys: String, CodingKey {

		case date = "date"
		case day = "day"
		case hours = "hours"
		case minutes = "minutes"
		case month = "month"
		case nanos = "nanos"
		case seconds = "seconds"
		case time = "time"
		case timezoneOffset = "timezoneOffset"
		case year = "year"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(Int.self, forKey: .date)
		day = try values.decodeIfPresent(Int.self, forKey: .day)
		hours = try values.decodeIfPresent(Int.self, forKey: .hours)
		minutes = try values.decodeIfPresent(Int.self, forKey: .minutes)
		month = try values.decodeIfPresent(Int.self, forKey: .month)
		nanos = try values.decodeIfPresent(Int.self, forKey: .nanos)
		seconds = try values.decodeIfPresent(Int.self, forKey: .seconds)
		time = try values.decodeIfPresent(Int.self, forKey: .time)
		timezoneOffset = try values.decodeIfPresent(Int.self, forKey: .timezoneOffset)
		year = try values.decodeIfPresent(Int.self, forKey: .year)
	}

}
