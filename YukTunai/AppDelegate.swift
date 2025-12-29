//
//  AppDelegate.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var applaunchOptions: [UIApplication.LaunchOptionsKey: Any]?

    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        applaunchOptions = launchOptions
        

        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = YTLunchScreenViewController()
        
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40
        

        if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            YTIDFVKeychainHelper.storeIDFV(idfv)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            CKTrackingManager.shared().requestAuthorization { s, v in
                upapisServices.shard.googleMarket(avp: v as! [String:String]) { resuult in
                    switch resuult {
                    case .success(let success):
                        print("google upload success---------google upload success------google upload success")
                        break
                    case .failure(let failure):
                        print("google upload error---------google upload error------google upload error")
                        break
                    }
                }
            }
        }
        
        
        let deviceInfo = DeviceInformationModel.uploadDeviceInfos()
        upapisServices.shard.approach(avp: ["upper":deviceInfo]) { result in
            switch result {
            case .success(let success):
                print("device upload success---------device upload success------device upload success")
                break
            case .failure(let failure):
                print("device upload error---------device upload error------device upload error")
                break
            }
        }
        
        
        YTLocationHelper.sharedInstance().requestLocation(withTimeout: 5) {[weak self] location, error in
             if let location = location {
                 let geocoder = CLGeocoder.init()
                 geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                     guard let self = self else { return }
                     if let placemark = placemarks?.first {
                         let info =  YTLocationHelper.sharedInstance().locationDetail(placemark, loca: location) as! [String:String]
                         upapisServices.shard.courageous(avp: info) { r in
                             switch r {
                             case .success(let success):
                                 print("shang bao weizhi xinxi chenggong ------------shang bao weizhi xinxi chenggong ------------shang bao weizhi xinxi chenggong ------------ ")
                                 break
                             case .failure(let failure):
                                 print("shang bao weizhi xinxi chu cuo ------------ ")
                                 break
                             }
                         }
                     }
                 }
             } else if let error = error {
                print("shang bao weizhi xinxi chu cuo ")
             }
         }
        
        YTAddressTools.shared.load()
        

        return true
    }

}







import FMDB
import SmartCodable



class Bloodlike: SmartCodable {
    var eyelid: String?
    var ensued: String?
    var wide: Int?
    var followed: [followedModels]?
    required init(){}
}


class followedModels: SmartCodable {
    var eyelid: String? // id
    var ensued: String? // name
    var wide: String? // code
    var tunnel: String? // provinceJson
    var followed: [followedModels]?
    var choised: Bool = false
    required init(){}
}



extension YTTools {
    
    static func filePat() -> URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("aresss.sqlite")
    }
}




class YTAddressTools {
    
    
    static let shared = YTAddressTools()
    
    private var db: FMDatabase!
    
    private let service = upapisServices()

    func load(){
        service.full { retul in
            switch retul {
            case .success(let success):
//                SVProgressHUD.showInfo(withStatus: "获取地址骶椎成功")
                (success?.upper)!.forEach {[weak self] item in
                    self?.savefollowed(item)
                }
                break
            case .failure(let failure):
//                SVProgressHUD.showInfo(withStatus: "获取地址骶椎失败----\(failure)")
                break
            }
        }
    }
    
    
    init() {
        
        db = FMDatabase(path: YTTools.filePat().relativePath)
        db.open()
        createTable()
    }
    
    deinit {
        db?.close()
    }
 

    private func createTable() {
        let createTableSQL = """
        CREATE TABLE IF NOT EXISTS Followed (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
                        eyelid TEXT,
                    ensued TEXT,
                    tunnel TEXT,
                    wide TEXT,
            parent_id INTEGER,
            choised INTEGER
        );
        """
        do {
            try db.executeUpdate(createTableSQL, values: nil)
        } catch {
            print("Failed to create table: \(error.localizedDescription)")
           
        }
    }
  
    
    
    func saveRapidInTransaction(followed: followedModels, parentId: Int?) {
        do {
            try db.beginTransaction()
            savefollowed(followed, parentId: parentId)
            try db.commit()
        } catch {
            db.rollback()
            print("Failed to insert Rapid: \(error.localizedDescription)")
         
        }
    }
    
    
    func savefollowed(_ followed: followedModels, parentId: Int? = nil) {
        
        guard !isfollowedModelsExist(followed, parentId: parentId) else {
                   return
               }
        
        do {
            try db.beginTransaction()
        
            var choised: Bool = false
            try db.executeUpdate("INSERT INTO Followed (eyelid, ensued, tunnel, wide, parent_id, choised) VALUES (?, ?, ?, ?, ?, ?)", values: [
                followed.eyelid ?? "",
                followed.ensued ?? "",
                followed.tunnel ?? "",
                followed.wide ?? "",
                parentId ?? NSNull(),
                followed.choised ? 1 : 0
            ])
            
            let lastInsertId = Int(db.lastInsertRowId)
            
            if let children = followed.followed {
                for child in children {
                    savefollowed(child, parentId: lastInsertId)
                }
            }
            print("fewfewfwefwefwfewfewfwe")
            try db.commit()
            
        } catch {
            db.rollback()
            print("FailedFailedFailedFailedFailedFailedFailedFailedFailed: \(error.localizedDescription)")
         
        }
    }
    
    func loadfollowedModels(from parentId: Int? = nil) -> [followedModels] {
        var followeds = [followedModels]()
        
        do {
            let rs = try db.executeQuery("SELECT * FROM Followed WHERE parent_id IS ?", values: [parentId ?? NSNull()])
            
            while rs.next() {
                let followed = followedModels()

                followed.eyelid = rs.string(forColumn: "eyelid")
                followed.ensued = rs.string(forColumn: "ensued")
                followed.tunnel = rs.string(forColumn: "tunnel")
                followed.wide = rs.string(forColumn: "wide")
                followed.choised = rs.bool(forColumn: "choised")
                
                let id = Int(rs.int(forColumn: "id"))
                followed.followed = loadfollowedModels(from: id)
                
                followeds.append(followed)
            }
        } catch {
            print("\(error.localizedDescription)")
        
        }
        
        return followeds
    }
    
    func clearTable() {
        do {
            try db.executeUpdate("DELETE FROM Rapid", values: nil)
        } catch {
            print(" \(error.localizedDescription)")
        }
    }
    
    private func isfollowedModelsExist(_ followedModel: followedModels, parentId: Int?) -> Bool {
           var exists = false
           do {
               let query = "SELECT COUNT(*) FROM Followed WHERE eyelid = ? AND ensued = ? AND tunnel = ? AND wide = ? AND parent_id IS ?"
               let rs = try db.executeQuery(query, values: [
                followedModel.eyelid ?? "",
                followedModel.ensued ?? "",
                followedModel.tunnel ?? "",
                followedModel.wide ?? "",
                   parentId ?? NSNull()
               ])
               if rs.next() {
                   exists = rs.int(forColumnIndex: 0) > 0
               }
           } catch {
               print("\(error.localizedDescription)")
            
           }
           return exists
       }
}







extension YTTools {
    
   static func findIndexes(from lookingString: String, in model: [followedModels]?) -> (index1: Int, index2: Int, index3: Int)? {
        let lookingComponents = lookingString.split(separator: "|").map { String($0) }
        guard lookingComponents.count == 3 else { return nil }

        guard let level1 = model else { return nil }
        
        if let index1 = level1.firstIndex(where: { $0.ensued == lookingComponents[0] }) {
            let level1Flawd = level1[index1]
            
            if let level2 = level1Flawd.followed,
               let index2 = level2.firstIndex(where: { $0.ensued == lookingComponents[1] }) {
                let level2Flawd = level2[index2]
                
                if let level3 = level2Flawd.followed,
                   let index3 = level3.firstIndex(where: { $0.ensued == lookingComponents[2] }) {
                    return (index1, index2, index3)
                }
            }
        }
        
        return nil
    }
    
    static func extractLookingValues(model: [followedModels]?, index1: Int, index2: Int, index3: Int) -> String? {
        guard let level1 = model, level1.indices.contains(index1) else {
            return nil
        }
        
        let level1Flawd = level1[index1]
        guard let level2 = level1Flawd.followed, level2.indices.contains(index2) else {
            return nil
        }
        
        let level2Flawd = level2[index2]
        guard let level3 = level2Flawd.followed, level3.indices.contains(index3) else {
            return nil
        }
        
        let level3Flawd = level3[index3]
        
        let lookingValues = [
            level1Flawd.ensued ?? "",
            level2Flawd.ensued ?? "",
            level3Flawd.ensued ?? ""
        ]
        
        return lookingValues.joined(separator: "|")
    }
    
    static func getLookingValues(model: [followedModels]?, index1: Int, index2: Int, index3: Int) -> (level1Looking: String?, level2Looking: String?, level3Looking: String?)? {
        guard let level1 = model, level1.indices.contains(index1) else {
            return nil
        }
        
        let level1Flawd = level1[index1]
        guard let level2 = level1Flawd.followed, level2.indices.contains(index2) else {
            return nil
        }
        
        let level2Flawd = level2[index2]
        guard let level3 = level2Flawd.followed, level3.indices.contains(index3) else {
            return nil
        }
        
        let level3Flawd = level3[index3]

        return (level1Flawd.ensued, level2Flawd.ensued, level3Flawd.ensued)
    }
}

