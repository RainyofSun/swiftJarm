
import UIKit
import AdSupport


struct YTPublicRequestURLTool {
    
    // 获取App版本
    static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    // 获取设备名称
    static func getDeviceName() -> String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0) // 获取 hw.machine 属性大小
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0) // 获取具体的设备型号
        return String(cString: machine)
    }
    
    // 获取设备ID (IDFV)
    static func getIDFV() -> String {
        return YTIDFVKeychainHelper.retrieveIDFV()
    }
    
    // 获取设备OS版本
    static func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    // 获取广告标识符 (IDFA)
    static func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    // 获取用户会话
    static func getSession() -> String {
        return "\(YTUserDefaults.shared.transport)"
    }
    
    // 获取额外参数
    static func getEn() -> String {
        return YTUserDefaults.shared.gash
    }
    
    // 构造公共URL后缀参数
    static func publicUrlSuffix() -> [String: String] {
        return [
            "shoes": getAppVersion(),
            "making": getDeviceName(),
            "sachs": getIDFV(),
            "nuremberg": getOSVersion(),
            "transport": getSession(),
            "call": getIDFA(),
            "gash": getEn()
        ]
    }
    
    // 根据基础URL创建带参数的完整URL
    static func createURLWithParameters(component: String) -> URL? {
        guard var components = URLComponents(string: component) else { return nil }
        
        // 添加公共参数
        let suffixQueryItems = publicUrlSuffix().map {
            URLQueryItem(name: $0.key, value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        }
        
        // 合并现有和新参数
        components.queryItems = (components.queryItems ?? []) + suffixQueryItems
        return components.url
    }
}
