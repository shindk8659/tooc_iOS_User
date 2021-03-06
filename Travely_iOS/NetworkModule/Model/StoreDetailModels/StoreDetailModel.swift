/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct StoreDetailModel : Codable {
    let storeIdx : Int?
    let ownerIdx : Int?
    let storeName : String?
    let storeCall : String?
    let storeUrl : String?
    let address : String?
    let addressNumber: String?
    let openTime : Int?
    let closeTime : Int?
    let latitude : Double?
    let longitude : Double?
    let limit : Int?
    let currentBag : Int?
    let grade : Double?
    let isFavorite : Int?
    let available: Int?
    let reviewResponseDtos : [ReviewResponseDtos]?
    let storeImageResponseDtos : [StoreImageResponseDtos]?
    let restWeekResponseDtos : [RestWeekResponseDtos]?
    
    enum CodingKeys: String, CodingKey {
        
        case storeIdx = "storeIdx"
        case ownerIdx = "ownerIdx"
        case storeName = "storeName"
        case storeCall = "storeCall"
        case storeUrl = "storeUrl"
        case address = "address"
        case addressNumber = "addressNumber"
        case openTime = "openTime"
        case closeTime = "closeTime"
        case latitude = "latitude"
        case longitude = "longitude"
        case limit = "limit"
        case currentBag = "currentBag"
        case grade = "grade"
        case isFavorite = "isFavorite"
        case available = "available"
        case reviewResponseDtos = "reviewResponseDtos"
        case storeImageResponseDtos = "storeImageResponseDtos"
        case restWeekResponseDtos = "restWeekResponseDtos"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
        ownerIdx = try values.decodeIfPresent(Int.self, forKey: .ownerIdx)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        storeCall = try values.decodeIfPresent(String.self, forKey: .storeCall)
        storeUrl = try values.decodeIfPresent(String.self, forKey: .storeUrl)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        addressNumber = try values.decodeIfPresent(String.self, forKey: .addressNumber)
        openTime = try values.decodeIfPresent(Int.self, forKey: .openTime)
        closeTime = try values.decodeIfPresent(Int.self, forKey: .closeTime)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        currentBag = try values.decodeIfPresent(Int.self, forKey: .currentBag)
        grade = try values.decodeIfPresent(Double.self, forKey: .grade)
        isFavorite = try values.decodeIfPresent(Int.self, forKey: .isFavorite)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        reviewResponseDtos = try values.decodeIfPresent([ReviewResponseDtos].self, forKey: .reviewResponseDtos)
        storeImageResponseDtos = try values.decodeIfPresent([StoreImageResponseDtos].self, forKey: .storeImageResponseDtos)
        restWeekResponseDtos = try values.decodeIfPresent([RestWeekResponseDtos].self, forKey: .restWeekResponseDtos)
    }
    
}
