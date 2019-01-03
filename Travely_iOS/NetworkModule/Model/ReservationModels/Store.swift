/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

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