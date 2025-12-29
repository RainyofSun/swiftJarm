

import UIKit
import Alamofire



extension CKService {
    
    func fetchData<M: CKNetModelProtocol>(target: T, responseClass: M.Type, completion: @escaping (Model<M>) -> Void){
       
        guard isConnectedToInternet else {
            completion(.failure(.UnKnow))
            return
        }
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])

        let params = buildParams(task: target.task)
        
   
        let p = YTPublicRequestURLTool.createURLWithParameters(component:  target.baseURL + target.path)!.absoluteString
        
   
        
        sessionManager.request(p,
                               method: method,
                               parameters: params.0,
                               encoding: params.1,
                               headers: headers)
            .cURLDescription { description in
                print(description)
              
            }
            .validate(statusCode: 200..<500)
            .responseData {[weak self] result in
                guard let _weakSelf = self else {
                   
                    return
                }
                switch result.result {
                case .success:
                   
                    _weakSelf.deserialize(with: result, target: target) { model in
                        completion(model)
                    }
                    break
                case .failure(let error):
                  
                    completion(.failure(.UnKnow))
                }
            }
    }
}



