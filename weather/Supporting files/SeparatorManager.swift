import UIKit
import Foundation

final class SeparatorManager {
    private let indent: CGFloat = 20
    static let shared = SeparatorManager()
    private init () {}

    func setSeparatorLineFor(style: Int, width: CGFloat) -> UIView {
        let line = UIView()
        line.backgroundColor = .white
        switch style {
        case 1:
            line.frame = CGRect(x: 0, y: 0, width: width, height: 1)
            return line
        case 2:
            line.frame = CGRect(x: indent, y: 0, width: width - 2 * indent, height: 1)
            return line
        case 3:
            line.frame = CGRect(x: 0, y: 133, width: width, height: 1)
            return line
        case 4:
            line.frame = CGRect(x: 0, y: 88, width: width, height: 1)
            return line
        default:
            return UIView()
        }
    }
    
}
