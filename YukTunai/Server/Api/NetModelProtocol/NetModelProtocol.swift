
import UIKit
import SmartCodable
import Alamofire







protocol TargetType {
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var method: CKHTTPMethod { get }
    
    var task: Task { get }
    
    var headers: [String: String]? { get }
    
}


enum CKHTTPMethod: String {
    
    case get = "GET"
    
    case post = "POST"
    
    case put = "PUT"
    
    case delete = "DELETE"
}


enum Task {

    case requestPlain

    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)

}


public protocol CKModelProtocol:SmartCodable {}


protocol CKNetModelProtocol: CKModelProtocol {
    
    associatedtype T: Codable


    var eyelid: Int {get set}
    

    var lip: String {get set}
    

    var upper:T? {get set}
    
}





final class CKBaseNetModel<M:Codable>: CKNetModelProtocol {

    var upper: M?

    var eyelid: Int = 0
    
    var lip: String = ""
    
    required init() {}
    
}


final class EmptyModel: SmartCodable {
    
}






