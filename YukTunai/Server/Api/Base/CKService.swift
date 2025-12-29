
import Foundation
import Alamofire


/*
 ---------------------------
 1. 文档地址：https://doc.alta-dg.mx/id_pinjam_laju_ios
 2. 文档反转义地址：https://doc.alta-dg.mx/decode.php?project=id_pinjam_laju_ios
 3. 接口访问地址：http://8.215.47.12/fundinghe
  
  
 接口文档账号：dev
 接口文档密码：fly2024
  
  
 4. 官方文档:https://developer.apple.com/support/third-party-SDK-requirements
 5. 隐私清单文档-必看(持续更新 ): http://47.238.207.2:3031/APP/AppPrivacyChecklist_doc.git
 账号：wendang
 密码：wendang123
  
  
 Tips:  接口调试流程注意文档  https://pwdgtjoqfr.feishu.cn/docx/PYMwdLwDwoey7pxH5fJcC0tlnRe
  
  
 6. 证件和流程调试补充文档  https://note.youdao.com/s/cJPkcHQz
  
  
 7. H5交互函数：
 DemonstrateVision()关闭当前webview
 ToThis(String url, String params)带参数页面跳转
 AboutOur()回到首页，并关闭当前页
 LaborOf() app store评分功能
 RaceIntroduce() 确认申请埋点调用方法
  
  
 8. 数据检查网站，可检查埋点数据，设备信息上报，位置信息上报，idfa&idfv上报 (可自行检查，有效期时长：45天):
 http://8.215.47.12:4058/index.html
 账号：admin
 密码：666666
 -----------------------------
 */

var HOST = "http://8.215.47.12/fundinghe"


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


