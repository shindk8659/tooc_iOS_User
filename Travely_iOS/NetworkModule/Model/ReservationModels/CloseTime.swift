/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CloseTime : Codable {
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