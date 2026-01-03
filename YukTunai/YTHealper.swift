
import UIKit

class YTUserDefaults{
    
    private init() {}
    
    static let shared = YTUserDefaults()
    
    private let userDefaults = UserDefaults.standard
    
}

extension  YTUserDefaults {
    
    func get<T>(forKey key: String) -> T? {
        return userDefaults.value(forKey: key) as? T
    }
    
    func set<T>(_ value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func clear() {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }
    
}






extension YTUserDefaults {
    
    var firstStart: Bool {
        get {
            return get(forKey: "firstStart") ?? false
        }
        set {
            set(newValue, forKey: "firstStart")
        }
    }
    
    var transport: String {
        get {
            return get(forKey: "transport") ?? ""
        }
        set {
            set(newValue, forKey: "transport")
        }
    }
    
    var arrogant: String {
        get {
            return get(forKey: "arrogant") ?? ""
        }
        set {
            set(newValue, forKey: "arrogant")
        }
    }
    
    var gash: String {
        get {
            return get(forKey: "gash") ?? ""
        }
        set {
            set(newValue, forKey: "gash")
        }
    }
    
    
    // 登录页是否强制拿 地理位置 权限字段  0否 1是
    var soothing: Int {
        get {
            return get(forKey: "soothing") ?? -1
        }
        set {
            set(newValue, forKey: "soothing")
        }
    }
    
    // 登录页是否强制拿 idfa 权限字段  0否 1是
    var bless: Int {
        get {
            return get(forKey: "bless") ?? -1
        }
        set {
            set(newValue, forKey: "bless")
        }
    }
    
    // 启动之后是否先展示登录 0否 1是
    var crack: Int {
        get {
            return get(forKey: "crack") ?? -1
        }
        set {
            set(newValue, forKey: "crack")
        }
    }
    
  

}
