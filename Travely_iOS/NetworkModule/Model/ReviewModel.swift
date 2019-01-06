//
//  ReviewModel.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/6/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
struct ReviewModel : Codable {
    let reviewIdx : Int?
    let storeIdx : Int?
    let userIdx : Int?
    let content : String?
    let like : Int?
    let createdAt : Int?
    let userName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case reviewIdx = "reviewIdx"
        case storeIdx = "storeIdx"
        case userIdx = "userIdx"
        case content = "content"
        case like = "like"
        case createdAt = "createdAt"
        case userName = "userName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reviewIdx = try values.decodeIfPresent(Int.self, forKey: .reviewIdx)
        storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        like = try values.decodeIfPresent(Int.self, forKey: .like)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
    }
    
}

