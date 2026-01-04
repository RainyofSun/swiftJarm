
import UIKit
import Alamofire
import SmartCodable



let HOMEJSON = "https://id-dc.oss-ap-southeast-5.aliyuncs.com/yuk-tunai/yuk.json"

let JSONNAME = "readjson.json"


extension CKService {

    enum MIMEType: String {
        case image = "image/png"
    }
    
    func uploadImages<M: CKNetModelProtocol>(target: T, responseClass: M.Type, completion: @escaping (Model<M>) -> Void, uploadProgress: @escaping (Double)->Void){
        
        guard isConnectedToInternet else {
            
            completion(.failure(.UnKnow))
            
            return
        }
        
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        
        let params = buildParams(task: target.task)
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let p = YTPublicRequestURLTool.createURLWithParameters(component:  target.baseURL + target.path)!.absoluteString
     
        sessionManager.upload(multipartFormData: { multipartFormData in
            
            if let image = params.0["hope"] as? Data {
                
                let filename = "\(arc4random())\((UUID().uuidString)).png"
                
                multipartFormData.append(image, withName: "ourProfiles", fileName: filename, mimeType: MIMEType.image.rawValue)
            }
           
            if let a = params.0["directly"] as? String {
                multipartFormData.append(Data(a.utf8), withName: "directly")
            }
            
            if let b = params.0["face"] as? String {
                multipartFormData.append(Data(b.utf8), withName: "face")
            }
            
        }, to: p, usingThreshold: UInt64(), method: method, headers: headers, interceptor: nil, fileManager: FileManager(), requestModifier: nil)
        
            .cURLDescription { description in
                
                print(description) 
                
            }
        
            .uploadProgress { progress in
                
                uploadProgress(progress.fractionCompleted)
                
            }
        
            .validate(statusCode: 200..<500)
        
            .responseData { [weak self] result in
                
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
                    return completion(.failure(_weakSelf.requestErrorHandle(with: error)))
                }
            }
        
    }
    
    func downloadJSONFile<M: CKNetModelProtocol>(target: T, responseClass: M.Type, completion: @escaping (Model<M>) -> Void) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(JSONNAME)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                completion(.failure(.UnKnow))
                return
            }
        }
        
        let destination: DownloadRequest.Destination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
 
        AF.download(HOMEJSON, to: destination).response { response in
            switch response.result {
            case .success(let fileURL):
                do {
                    let fileData = try Data(contentsOf: fileURL!)
                    if let jsonString = String(data: fileData, encoding: .utf8) {
                        let datas = [homeURLList].deserialize(from: jsonString)
                        let mode = CKBaseNetModel<[homeURLList]>()
                        mode.upper = datas
                        mode.eyelid = 0
                        mode.lip = "success"
                        completion(.success(mode as? M))
                    } else {
                        completion(.failure(.UnKnow))
                    }
                } catch {
                    completion(.failure(.UnKnow))
                }
            case .failure(let error):
                completion(.failure(.UnKnow))
            }
        }
    }
}


class homeURLList: SmartCodable{
    
    var yu: String?
    
    required init(){}
}
