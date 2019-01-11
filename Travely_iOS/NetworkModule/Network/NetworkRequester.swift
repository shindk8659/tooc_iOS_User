//
//  NetworkRequester.swift
//  Travely_iOS
//
//  Created by 신동규 on 12/29/18.
//  Copyright © 2018 신동규. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


enum NetworkError: Error {
    case failure
}
struct NetworkRequester {
    
    
    private var api: APIRouter
    private let manager = Alamofire.SessionManager.default
    public typealias Completion1<T> = ((T?,ErrorModel?, Error?) -> Void)?
    public typealias Completion2<T> = ((T?,[ErrorModel?]?, Error?) -> Void)?
    public typealias Completion3<T> = (([T?]?,ErrorModel?, Error?) -> Void)?
    public typealias Completion4<T> = (([T?]?,[ErrorModel?]?, Error?) -> Void)?
    public typealias CompletionOtherAPI<T> = ((T?, Error?) -> Void)?
    
    init(with router: APIRouter) {
        self.api = router
        manager.session.configuration.timeoutIntervalForRequest = 15
    }
    
    func request1<T: Codable>(completion: Completion1<T>) {
        manager.request(api.requestUrl, method: api.method, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers)
            .validate(contentType: ["application/json"]).responseData { response in
                switch response.result {
                case .success:
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)")
                        guard resultStatusCode < 300 else {
                            // 오류 메세지 들어올 경우
                            let data = response.data
                            let jsonString = JSON(data as Any).description
                            let jsonData = jsonString.data(using: .utf8) ?? Data()
                            do {
                                let result = try JSONDecoder().decode(ErrorModel.self, from: jsonData)
                                completion?(nil, result, nil)
                            } catch {
                                
                            }
                            return
                        }
                        let headers = response.response?.allHeaderFields as! [String:String]
                        if headers["jwt"] != nil {
                            let jwt: String? = headers["jwt"]
                            let userdata = UserDefaults.standard
                            userdata.set(jwt, forKey: "jwt")
                            userdata.synchronize()
                        }
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            completion?(result, nil, nil)
                        } catch let catchError{
                            print("캐치에러 \(catchError)")
                        }
                    }
                    
                case .failure(let failError):
                    //네트워크 자체가 안 될 경우
                    completion?(nil,nil, failError)
                }
        }
        

    }
    
    func request2<T: Codable>(completion: Completion2<T>) {
        
        manager.request(api.requestUrl, method: api.method, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers)
            .validate(contentType: ["application/json"]).responseData { response in
                switch response.result {
                case .success:
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)")
                        guard resultStatusCode < 300 else {
                            // 오류 메세지 들어올 경우
                            let data = response.data
                            let jsonString = JSON(data as Any).description
                            let jsonData = jsonString.data(using: .utf8) ?? Data()
                            do {
                                let result = try JSONDecoder().decode([ErrorModel].self, from: jsonData)
                                completion?(nil, result, nil)
                            } catch {
                                
                            }
                            return
                        }
                        let headers = response.response?.allHeaderFields as! [String:String]
                        if headers["jwt"] != nil {
                            let jwt: String? = headers["jwt"]
                            let userdata = UserDefaults.standard
                            userdata.set(jwt, forKey: "jwt")
                            userdata.synchronize()
                        }
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            completion?(result, nil, nil)
                        } catch let catchError{
                            print("캐치에러 \(catchError)")
                        }
                    }
                    
                case .failure(let failError):
                    //네트워크 자체가 안 될 경우
                    completion?(nil,nil, failError)
                    
                    
                }
        }
        
    }
    
    func request3<T: Codable>(completion: Completion3<T>) {
        manager.request(api.requestUrl, method: api.method, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers)
            .validate(contentType: ["application/json"]).responseData { response in
                switch response.result {
                    
                case .success:
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)")
                        guard resultStatusCode < 300 else {
                            // 오류 메세지 들어올 경우
                            let data = response.data
                            let jsonString = JSON(data as Any).description
                            let jsonData = jsonString.data(using: .utf8) ?? Data()
                            do {
                                let result = try JSONDecoder().decode(ErrorModel.self, from: jsonData)
                                completion?(nil, result, nil)
                            } catch {
                                
                            }
                            return
                        }
                        let headers = response.response?.allHeaderFields as! [String:String]
                        if headers["jwt"] != nil {
                            let jwt: String? = headers["jwt"]
                            let userdata = UserDefaults.standard
                            userdata.set(jwt, forKey: "jwt")
                            userdata.synchronize()
                        }
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode([T].self, from: jsonData)
                            completion?(result, nil, nil)
                        } catch let catchError {
                            print("캐치에러 \(catchError)")
                        }
                    }
                    
                case .failure(let failError):
                    //네트워크 자체가 안 될 경우
                    completion?(nil,nil, failError)
                }
        }
    }
    
    func requestOtherAPI<T: Codable>(completion: CompletionOtherAPI<T>) {
        manager.request(api.url, method: api.method, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)")
                        let data = response.data
                        let jsonString = JSON(data as Any).description
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            completion?(result, nil)
                        } catch {
                            
                        }
                    }
                case .failure(let failError):
                    //네트워크 자체가 안 될 경우
                    completion?(nil, failError)
                }
        }
    }
    
    func requestMultipartFormData<T: Codable>(completion: Completion1<T>) {
        manager.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(self.api.data!, withName: "data", fileName: "image_name.jpeg", mimeType: "image/jpeg")
        }, usingThreshold: UInt64.init(), to: api.requestUrl, method: api.method, headers: api.headers) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseData(completionHandler: { response in
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)\(response.description)")
                        guard resultStatusCode < 300 else {
                            // 오류 메세지 들어올 경우
                            let data = response.data
                            let jsonString = JSON(data as Any).description
                            let jsonData = jsonString.data(using: .utf8) ?? Data()
                            do {
                                let result = try JSONDecoder().decode(ErrorModel.self, from: jsonData)
                                completion?(nil, result, nil)
                            } catch {
                                
                            }
                            return
                        }
                        let headers = response.response?.allHeaderFields as! [String:String]
                        if headers["jwt"] != nil {
                            let jwt: String? = headers["jwt"]
                            let userdata = UserDefaults.standard
                            userdata.set(jwt, forKey: "jwt")
                            userdata.synchronize()
                        }
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            completion?(result, nil, nil)
                        } catch let catchError{
                            print("캐치에러 \(catchError)")
                        }
                    }
                })
                upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            case .failure(let err):
                completion?(nil,nil, err)
            }
        }
    }
}
