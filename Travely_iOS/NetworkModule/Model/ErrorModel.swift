//
//  ErrorModel.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation

struct ErrorModel : Codable {
    let field : String?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case field = "field"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        field = try values.decodeIfPresent(String.self, forKey: .field)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}
