
import Foundation
import Alamofire



var HOST = "https://yt.sheth-fincap.com/strike"


enum YKError: Error {
    case UnKnow
    case defaultE(String)
}

extension YKError {
    
    var description: String {
        
        switch self {
        case .defaultE(let type):
            
            return type
        default:
            return "Error"
        }

    }
}


typealias Model<M> = Result<M?, YKError>


typealias SuccessHandler<M> = (M?)->Void


typealias FailureHandler = (YKError?)->Void




class CKService<T: TargetType>: NSObject {
    

    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }


    let sessionManager: Session = {

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30

        // 使用配置创建 Session
        return Session(configuration: configuration)
    }()
    
    override init() {
        super.init()
    }
    
}




extension CKService {
    

    func cancelRequest(){
        sessionManager.cancelAllRequests()
    }
    

    func buildParams(task: Task) -> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
}





extension CKService {
    

    func requestErrorHandle(with error: AFError) -> YKError {
        return .UnKnow
    }
    
    func deserialize<M:CKNetModelProtocol>(with result:AFDataResponse<Data>,target: T,completion: @escaping (Model<M>) -> Void){
        
        var error: YKError = .UnKnow

        guard let response = try? result.result.get() else {
          
            error = .UnKnow
            completion(.failure(error))
            return
        }
        
        guard let dict = try? JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else {
            error = .UnKnow
           
            completion(.failure(error))
            return
        }
        
        print(dict)
        
        
        if let model = M.deserialize(from: dict) {
            if model.eyelid != 0 {
                error = .UnKnow
                completion(.failure(.defaultE(model.lip)))
                return
            }
            completion(.success(model))
        }
        
    }

    
}


