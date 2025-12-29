
import UIKit


extension String {
    
    var removeAllSepace: String {
           return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
}
