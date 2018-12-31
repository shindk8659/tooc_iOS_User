//
//  NetworkManager.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {
   
    func login(email:String, password:String, completion: @escaping (ErrorModel?,ErrorModel?,Error?) -> Void) {
        
        let parameters = [
            "email": email,
            "password": password
        ]
        let router = APIRouter(url:"/api/users/login", method: .post, parameters: parameters)
        NetworkRequester(with: router).request1 { (login: ErrorModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(login,errorModel,error)
        }
    }
    
    func signin(email:String, password:String, configPassword:String,name:String,phone:String, completion: @escaping (ErrorModel?,[ErrorModel?]?,Error?) -> Void) {
        
        let parameters = [
            "email": email,
            "password": password,
            "configPassword": configPassword,
            "name": name,
            "phone": phone
        ]
        let router = APIRouter(url:"/api/users", method: .post, parameters: parameters)
        NetworkRequester(with: router).request2 { (signin:ErrorModel?, errorModel:[ErrorModel?]?, error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(signin,errorModel,error)
        }
    }
    
    func regionList(jwt:String, completion: @escaping ([RegionListModel?]?,ErrorModel?,Error?) -> Void) {
        
        let header = [
            "jwt": jwt
        ]
        let router = APIRouter(url: "/api/region", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).request3 { (signin:[RegionListModel?]?, errorModel:ErrorModel?, error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(signin,errorModel,error)
        }
    }
}
