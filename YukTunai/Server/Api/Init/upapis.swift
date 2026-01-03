//
//  upapis.swift
//  YukTunai
//
//  Created by whoami on 2024/11/24.
//

import UIKit
import Alamofire

enum upapis: TargetType {
    
    case googleMarket([String:String])
    case tumult([String:String])
    case courageous([String:String])
    case approach([String:String])
    case crushing([String:String])
    case full
    
    var baseURL: String {
        return HOST
    }
    
    var path: String {
        switch self {
        case .googleMarket:
            return "/tumult/everystep"
        case .tumult:
            return "/tumult/tumult"
        case .courageous:
            return "/tumult/courageous"
        case .approach:
            return "/tumult/approach"
        case .crushing:
            return "/tumult/crushing"
        case .full:
            return "/tumult/full"
        }
    }
    
    var method: CKHTTPMethod {
        switch self {
        case .googleMarket,.tumult,.courageous,.approach,.crushing:
            return .post
        case .full:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .full:
            return .requestPlain
        case .googleMarket(let av):
            return .requestParameters(parameters:av, encoding: URLEncoding.httpBody)
        case .tumult(let av):
            return .requestParameters(parameters:av, encoding: URLEncoding.httpBody)
        case .courageous(let av):
            return .requestParameters(parameters:av, encoding: URLEncoding.httpBody)
        case .approach(let av):
            return .requestParameters(parameters:av, encoding: URLEncoding.httpBody)
        case .crushing(let av):
            return .requestParameters(parameters:av, encoding: URLEncoding.httpBody)
        }
           
    }
    
    var headers: [String : String]? {
        return nil
    }

}


protocol upapisServicesp {
    func googleMarket(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    
    func tumult(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    
    func courageous(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    
    func approach(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    
    func crushing(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    
    func full(completion: @escaping(Result<CKBaseNetModel<[followedModels]>?, YKError>) -> Void)
}


class upapisServices: CKService<upapis>, upapisServicesp {
    
    // 城市列表
    func full(completion: @escaping (Result<CKBaseNetModel<[followedModels]>?, YKError>) -> Void) {
        fetchData(target: upapis.full, showLoading: false, responseClass: CKBaseNetModel<[followedModels]>.self) { result in
            completion(result)
        }
    }
    
    func tumult(avp: [String : String], completion: @escaping (Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: upapis.tumult(avp), showLoading: false, responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
    func courageous(avp: [String : String], completion: @escaping (Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: upapis.courageous(avp), showLoading: false, responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
    func approach(avp: [String : String], completion: @escaping (Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: upapis.approach(avp), showLoading: false, responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
    func crushing(avp: [String : String], completion: @escaping (Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: upapis.crushing(avp), showLoading: false, responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
    
    static let shard:upapisServices = upapisServices()
    
    func googleMarket(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void){
        fetchData(target: upapis.googleMarket(avp), showLoading: false, responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
}
