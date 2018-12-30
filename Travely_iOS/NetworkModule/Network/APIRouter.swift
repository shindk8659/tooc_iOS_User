//
//  APIRouter.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Alamofire

struct APIConfiguration {
    static let baseURL = "http://52.78.222.197:8080"
   
}

struct APIRouter {
    var url: String
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    init(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
}
extension APIRouter {
    var requestUrl: String {
        return APIConfiguration.baseURL + url
    }
    
}
