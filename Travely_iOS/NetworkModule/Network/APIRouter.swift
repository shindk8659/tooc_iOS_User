//
//  APIRouter.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Alamofire

struct APIConfiguration {
    static let baseURL = "https://tooc.tk"

}

struct APIRouter {
    var url: String
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var data: Data?
    
    init(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, data: Data? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.data = data
    }
    
}
extension APIRouter {
    var requestUrl: String {
        return APIConfiguration.baseURL + url
    }
}
