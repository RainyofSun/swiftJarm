//
//  InitApis.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//


import Foundation
import Alamofire


enum InitApis {
    case schlaeger(String,[String:String])
    case suabian(String)
    case dexterous(String)
    case eyelid([String:String])
    case lip
    case bottles
    case info
    case home
    case gash([String:String])
    case days([String:String])
    
    case userInfo
    
    case fought([String:String])
    case hands([String:Any])
    case duels([String:String])
    
    case homes([String:String])
    case went([String:String])
    
    case junge([String:String])
    case dummer([String:String])
    
    case impertinent([String:String])
    case absurd([String:String])
    
    case arrogant([String:String])
    case offensive([String:String])
    
    case uproar([String:String])
    
    case renowning([String:String])
    
    case hjnca([String:String])
    
    case jsons(String)
}


extension InitApis: TargetType {
        var baseURL: String {
        switch self {
        case .jsons(let h):
            return h
        case .schlaeger(let h, _):
            return h
        default:
            return HOST
        }
      
    }
    
    var path: String {
        switch self {
        case .jsons:
            return HOMEJSON
        case .schlaeger:
            return "/tumult/schlaeger"
        case .suabian(_):
            return "/tumult/suabian"
        case .dexterous:
            return "/tumult/dexterous"
        case .eyelid:
            return "/tumult/eyelid"
        case .lip:
            return "/tumult/lip"
        case .bottles:
            return "/tumult/bottles"
        case .info:
            return "/tumult/ensued"
        case .home:
            return "/tumult/upper"
        case .gash:
            return "/tumult/gash"
        case .days:
            return "/tumult/days"
        case .fought:
            return "/tumult/fought"
        case .hands:
            return "/tumult/hands"
        case .duels:
            return "/tumult/duels"
        case .homes:
            return "/tumult/home"
        case .went:
            return "/tumult/went"
        case .junge:
            return "/tumult/junge"
        case .dummer:
            return "/tumult/dummer"
        case .impertinent:
            return "/tumult/impertinent"
        case .absurd:
            return "/tumult/absurd"
        case .arrogant(_):
            return "/tumult/arrogant"
        case .offensive(_):
            return "/tumult/offensive"
        case .uproar:
            return "/tumult/uproar"
        case .renowning(_):
            return "/tumult/renowning"
        case .hjnca(_):
            return "/tumult/hjnca"
        case .userInfo:
            return "/v3/personal-center/user-info"
        }
    }
    
    var method: CKHTTPMethod {
        switch self {
        case .schlaeger,.suabian,.dexterous,.eyelid,.lip,.info,.home:
            return .get
        case .bottles,.userInfo,.gash,.days,.fought,.hands,.duels,.homes,.went,.junge,.dummer,.impertinent,.absurd:
            return .post
        case .arrogant(_):
            return .post
        case .offensive(_):
            return .post
        case .uproar:
            return .post
        case .renowning(_):
            return .post
        case .hjnca(_):
            return .post
        case .jsons(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .uproar(let av):
            return .requestParameters(parameters:av, encoding: URLEncoding.httpBody)
        case .schlaeger(_,let avp),.eyelid(let avp):
            return .requestParameters(parameters:avp, encoding: URLEncoding.default)
        case .gash(let avp),.fought(let avp):
            return .requestParameters(parameters:avp, encoding: URLEncoding.httpBody)
        case .days(let avp),.duels(let avp),.homes(let avp),.went(let avp),.junge(let avp),.dummer(let avp),.impertinent(let avp),.absurd(let avp):
            return .requestParameters(parameters:avp, encoding: URLEncoding.httpBody)
        case .hands(let avp):
            return .requestParameters(parameters:avp, encoding: URLEncoding.httpBody)
        case .suabian(let avp):
            return .requestParameters(parameters:["absurd":avp], encoding: URLEncoding.default)
        case .dexterous(let avp):
            return .requestParameters(parameters:["absurd":avp], encoding: URLEncoding.default)
        case .lip,.bottles,.info,.home:
            return .requestPlain
        case .arrogant(let avp):
            return .requestParameters(parameters:avp, encoding: URLEncoding.httpBody)
        case .offensive(let avp):
            return .requestParameters(parameters:avp, encoding: URLEncoding.httpBody)
        case .renowning(let avp):
            return .requestParameters(parameters:avp, encoding: URLEncoding.httpBody)
        case .hjnca(let avp):
            return .requestParameters(parameters:avp, encoding: URLEncoding.httpBody)
        case .jsons(_),.userInfo:
              return  .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }

}


