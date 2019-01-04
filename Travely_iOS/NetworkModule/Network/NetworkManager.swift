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
    let jwt = UserDefaults.standard.string(forKey: "jwt")
    
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
    
    func regionList(completion: @escaping ([RegionListModel?]?,ErrorModel?,Error?) -> Void) {
        
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let router = APIRouter(url: "/api/region", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).request3 { (regionList:[RegionListModel?]?, errorModel:ErrorModel?, error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(regionList,errorModel,error)
        }
    }
    
    func storeDetail(storeIdx:Int, completion: @escaping (StoreDetailModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let router = APIRouter(url:"/api/store/\(storeIdx)", method: .get, parameters: nil ,headers:header)
        NetworkRequester(with: router).request1 { (storeDetailList: StoreDetailModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(storeDetailList,errorModel,error)
        }
    }
    
    func saveReservation(storeIdx: Int, startTime: Int, endTime: Int, bagDtos: [[String: Any]], payType: String, completion: @escaping(ReservationModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let param: [String:Any] = [
            "storeIdx" : storeIdx,
            "startTime" : startTime,
            "endTime" : endTime,
            "bagDtos" : bagDtos,
            "payType" : payType
        ]
        let router = APIRouter(url:"/api/reservation", method: .post, parameters: param ,headers:header)
        NetworkRequester(with: router).request1 { (reservationDetail: ReservationModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(reservationDetail,errorModel,error)
        }
    }
    
    
    
    
}
