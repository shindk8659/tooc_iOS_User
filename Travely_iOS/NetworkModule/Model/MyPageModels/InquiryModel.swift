//
//  InquiryModel.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct InquiryModel: Codable {
    let inquiryImgs : [String]?
    let content : String?
    let createAt : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case inquiryImgs = "inquiryImgs"
        case content = "content"
        case createAt = "createAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        inquiryImgs = try values.decodeIfPresent([String].self, forKey: .inquiryImgs)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        createAt = try values.decodeIfPresent(Int.self, forKey: .createAt)
    }
}
