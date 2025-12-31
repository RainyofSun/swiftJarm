//
//  ViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//


import Foundation
import SmartCodable


protocol InitApiServicesp {
    func schlaeger(h:String,avp: [String:String],completion: @escaping(Result<CKBaseNetModel<schlaegerModel>?, YKError>) -> Void)
    func suabian(avp: String,completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    func dexterous(avp: String,completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    func eyelid(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<eyelidModel>?, YKError>) -> Void)
    func info(completion: @escaping(Result<CKBaseNetModel<infoModel>?, YKError>) -> Void)
    func lip(completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    func bottles(completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    func home(completion: @escaping(Result<CKBaseNetModel<homeModel>?, YKError>) -> Void)
    func gash(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<HomegashmODEL>?, YKError>) -> Void)
    func days(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<daysModel>?, YKError>) -> Void)
    
    func fought(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<marchedFaceModel>?, YKError>) -> Void)
    func hands(avp: [String:Any],completion: @escaping(Result<CKBaseNetModel<FACEhandsModel>?, YKError>) -> Void)
    func duels(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    
    
    func homes(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void)
    func went(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
  
    func junge(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void)
    func dummer(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
  
    func impertinent(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<impertinentModel>?, YKError>) -> Void)
    func absurd(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
  

    func offensive(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void)
    func arrogant(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void)
  
    func uproar(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<uproarModel>?, YKError>) -> Void)
  
    func renowning(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<zhongjianModel>?, YKError>) -> Void)
  
    func hjnca(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<leaveModel>?, YKError>) -> Void)
    
    func rrrrrr(completion: @escaping(Result<CKBaseNetModel<reddddd>?, YKError>) -> Void)
    
    func defaultjsons(lj: String,completion: @escaping(Result<CKBaseNetModel<[homeURLList]>?, YKError>) -> Void)
}


class InitApiServices: CKService<InitApis>, InitApiServicesp {
    
    func rrrrrr(completion: @escaping (Result<CKBaseNetModel<reddddd>?, YKError>) -> Void) {
        fetchData(target: InitApis.userInfo, responseClass: CKBaseNetModel<reddddd>.self) { result in
            completion(result)
        }
    }
    
    
    func defaultjsons(lj:String,completion: @escaping (Result<CKBaseNetModel<[homeURLList]>?, YKError>) -> Void) {
        downloadJSONFile(target: InitApis.jsons(lj), responseClass: CKBaseNetModel<[homeURLList]>.self) { re in
            completion(re)
        }
    }
    
    
    
    func hjnca(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<leaveModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.hjnca(avp), responseClass: CKBaseNetModel<leaveModel>.self) { result in
            completion(result)
        }
    }
    
    func renowning(avp: [String : String], completion: @escaping (Result<CKBaseNetModel<zhongjianModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.renowning(avp), responseClass: CKBaseNetModel<zhongjianModel>.self) { result in
            completion(result)
        }
    }
    
    func uproar(avp: [String : String], completion: @escaping (Result<CKBaseNetModel<uproarModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.uproar(avp), responseClass: CKBaseNetModel<uproarModel>.self) { result in
            completion(result)
        }
    }
    
    func arrogant(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.arrogant(avp), responseClass: CKBaseNetModel<homesModel>.self) { result in
            completion(result)
        }
    }
    
    func offensive(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.offensive(avp), responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    

   
  
    
    func impertinent(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<impertinentModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.impertinent(avp), responseClass: CKBaseNetModel<impertinentModel>.self) { result in
            completion(result)
        }
    }
  
    func absurd(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.absurd(avp), responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
  
  
    
    
    func dummer(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.dummer(avp), responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
  
    func junge(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.junge(avp), responseClass: CKBaseNetModel<homesModel>.self) { result in
            completion(result)
        }
    }
 
    
    func went(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.went(avp), responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
  
    func homes(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.homes(avp), responseClass: CKBaseNetModel<homesModel>.self) { result in
            completion(result)
        }
    }
    
    func duels(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.duels(avp), responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
    func hands(avp: [String:Any],completion: @escaping(Result<CKBaseNetModel<FACEhandsModel>?, YKError>) -> Void) {
        uploadImages(target: InitApis.hands(avp), responseClass: CKBaseNetModel<FACEhandsModel>.self) { r in
            completion(r)
        } uploadProgress: { p in
        }
    }
    
    func fought(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<marchedFaceModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.fought(avp), responseClass: CKBaseNetModel<marchedFaceModel>.self) { result in
            completion(result)
        }
    }
    
    
    
    func days(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<daysModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.days(avp), responseClass: CKBaseNetModel<daysModel>.self) { result in
            completion(result)
        }
    }
    
    func gash(avp: [String:String],completion: @escaping (Result<CKBaseNetModel<HomegashmODEL>?, YKError>) -> Void) {
        fetchData(target: InitApis.gash(avp), responseClass: CKBaseNetModel<HomegashmODEL>.self) { result in
            completion(result)
        }
    }
    
    
    func  home(completion: @escaping (Result<CKBaseNetModel<homeModel>?, YKError>) -> Void){
        fetchData(target: InitApis.home, responseClass: CKBaseNetModel<homeModel>.self) { result in
            completion(result)
        }
    }
    
    func  lip(completion: @escaping (Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void){
        fetchData(target: InitApis.lip, responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
    func  bottles(completion: @escaping (Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void){
        fetchData(target: InitApis.bottles, responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
    
    func info(completion: @escaping (Result<CKBaseNetModel<infoModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.info, responseClass: CKBaseNetModel<infoModel>.self) { result in
            completion(result)
        }
    }
    
  
    func schlaeger(h:String,avp: [String:String],completion: @escaping(Result<CKBaseNetModel<schlaegerModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.schlaeger(h,avp), responseClass: CKBaseNetModel<schlaegerModel>.self) { result in
            completion(result)
        }
    }
    
    func eyelid(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<eyelidModel>?, YKError>) -> Void) {
        fetchData(target: InitApis.eyelid(avp), responseClass: CKBaseNetModel<eyelidModel>.self) { result in
            completion(result)
        }
    }
    
    func  suabian(avp: String, completion: @escaping (Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void){
        fetchData(target: InitApis.suabian(avp), responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
    
    func  dexterous(avp: String, completion: @escaping (Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void){
        fetchData(target: InitApis.dexterous(avp), responseClass: CKBaseNetModel<EmptyModel>.self) { result in
            completion(result)
        }
    }
}




class schlaegerModel: SmartCodable {
    var gash: Int?
    var fought: foughtModel?
    required init(){}
}

class foughtModel: SmartCodable {
    var hands: String?
    var duels: String?
    var homes: String?
    var went: String?
    required init(){}
}


class eyelidModel: SmartCodable {
    var arrogant: String?
    var uproar: String?
    var transport: String?
    required init(){}
}


class reddddd: SmartCodable {
    var ensued: String?
    var pipe: String?
    var tumult: String?
    var full: String?
    required init(){}
}




class infoModel: SmartCodable {
    var along: [alongModel]?
    var inverted: invertedModel?
    var victorious: victoriousModel?
    required init(){}
}

class alongModel: SmartCodable {
    var downward: String?
    var stride: String?
    var courageous: String?
    required init(){}
}



class invertedModel: SmartCodable {
    var absurd: String?
    var uproar: String?
    required init(){}
}

class victoriousModel: SmartCodable {
    var downward: String?
    var drawn: String?
    var hit: String?
    var succession: String?
    required init(){}
}



class homeModel: SmartCodable {
    var along: [homealongModel]?
    var courageous: homecon?
    required init(){}
}


class homecon: SmartCodable{
    var    loanUrl : String?
    var    everystep : String?
    var privateUrl: String?
    var preScore: Int?

    required init(){}
}

class homealongModel: SmartCodable {
    var directly: String?
    var marched: [marchedModel]?
    required init(){}
}

class leaveModel: SmartCodable {
    var soft: String?
    required init(){}
}



class marchedModel: SmartCodable {
    var wide: String?
    var marched: Int?
    var bare: String?
    var neck: String?
    var coat: String?
    var smoky: String?
    var dim: String?
    var stalking: String?
    var drunk: String?
    var lead: String?
    var sheet: String?
    var whistled: String?
    var treatment: String?
    required init(){}
}


class HomegashmODEL: SmartCodable {
    var combatants: Int?
    var stride: String?
    var gash: String?
    var directly: Int?
    required init(){}
}


class uproarModel:SmartCodable {
    var stride: String?
    required init(){}
}



class impertinentModel:SmartCodable {
    var smokes: [smokesModel]?
    required init(){}
}


class smokesModel:SmartCodable {
    var downward: String?
    var knits: String?
    var ur: String?
    var mamsell: String?
    var mama: String?
    var rector: String?
    var ensued: String?
    var stockings: String?
    var rose: [roseModel]?
    required init(){}
}


