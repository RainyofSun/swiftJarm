
import UIKit

protocol CKCellable {
    
    static var identifier: String { get }
    
}

extension CKCellable {
    
    static var identifier : String {
        return "\(self)"
    }
    
}


extension UITableViewCell: CKCellable { }

extension UICollectionReusableView: CKCellable { }

extension UITableViewHeaderFooterView: CKCellable {}
