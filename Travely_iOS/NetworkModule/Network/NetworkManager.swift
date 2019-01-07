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
    
    func login(email:String, password:String, completion: @escaping (LoginModel?,ErrorModel?,Error?) -> Void) {
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        let router = APIRouter(url:"/api/users/login", method: .post, parameters: parameters)
        NetworkRequester(with: router).request1 { (login: LoginModel?, errorModel:ErrorModel? , error) in
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
    
    func bringPriceList(completion: @escaping([PriceList?]?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let router = APIRouter(url:"/api/reservation/price/list", method: .get, parameters: nil ,headers:header)
        NetworkRequester(with: router).request3 { (result: [PriceList?]?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(result,errorModel,error)
        }
    }
    
    func bringReservationInfo(completion: @escaping(ReservationInfo?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let router = APIRouter(url:"/api/reservation", method: .get, parameters: nil ,headers:header)
        NetworkRequester(with: router).request1 { (result: ReservationInfo?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(result,errorModel,error)
        }
    }
    
    func cancelReservation(completion: @escaping(ErrorModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
    ]
    let router = APIRouter(url:"/api/reservation", method: .delete, parameters: nil ,headers:header)
        NetworkRequester(with: router).request1 { (result: ErrorModel?, errorModel:ErrorModel? , error) in
        guard error == nil else {
            completion(nil,errorModel,error)
        return
        }
        completion(result,errorModel,error)
    }
    }
    
    func getProfileInfo(completion: @escaping(ProfileModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let router = APIRouter(url:"/api/users/profile", method: .get, parameters: nil ,headers:header)
        NetworkRequester(with: router).request1 { (profile: ProfileModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(profile,errorModel,error)
        }
    }
    
    
    func getMyReview(completion: @escaping([MyReviewModel?]?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let router = APIRouter(url:"/api/review", method: .get, parameters: nil ,headers:header)
        NetworkRequester(with: router).request3 { (review: [MyReviewModel?]?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(review,errorModel,error)
        }
    }
    
    func getFavoriteStore(completion: @escaping([FavoriteModel?]?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let router = APIRouter(url:"/api/favorite", method: .get, parameters: nil ,headers:header)
        NetworkRequester(with: router).request3 { (review: [FavoriteModel?]?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(review,errorModel,error)
        }
    }
    
    func deleteReview(reviewIdx:Int, completion: @escaping(ErrorModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        print(reviewIdx)
        let router = APIRouter(url:"/api/review/delete/\(reviewIdx)", method: .delete, parameters: nil ,headers:header)
        NetworkRequester(with: router).request1 { (review:ErrorModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(review,errorModel,error)
        }
    }
    
    func makeReview(storeIdx:Int,content:String,liked:Int, completion: @escaping(ReviewModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let parameter:[String:Any] = [
            "storeIdx":storeIdx,
            "content":content,
            "liked":liked
        ]
        let router = APIRouter(url:"/api/review/save", method: .post, parameters: parameter ,headers:header)
        NetworkRequester(with: router).request1 { (review:ReviewModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(review,errorModel,error)
        }
    }
    
    func setFavorite(storeIdx:Int, completion: @escaping(SetFavoriteModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
       
        let router = APIRouter(url:"/api/favorite/\(storeIdx)", method: .put, parameters: nil ,headers:header)
        NetworkRequester(with: router).request1 { (review:SetFavoriteModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(review,errorModel,error)
        }
    }
    
    func getCurrentLocation(lat:Double,long:Double,completion: @escaping(CurrentLocation?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "Content-Type": "application/json",
            "X-NCP-APIGW-API-KEY-ID":"icdkg66i3x",
            "X-NCP-APIGW-API-KEY":"0R1DKbvvFk9C2vt5DfF7vA7WeHAgWmxTLXirf51e"
        ]
        let router = APIRouter(url:"https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=\(long),\(lat)&sourcecrs=epsg:4326&output=json&orders=legalcode", method: .get, parameters: nil ,headers:header)
        NetworkRequester(with: router).requestOtherAPI{ (review:CurrentLocation?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(review,error)
        }
    }

    
    
}
