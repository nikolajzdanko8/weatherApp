import UIKit

public extension UILabel {
    func edgeTo(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
        func setHighlightedText(value: String?, highlight: String?) {
            guard let value = value, let highlight = highlight else {return}
            let attributedText = NSMutableAttributedString(string: value)
            let range = (value as NSString).range(of: highlight, options: .caseInsensitive)
            let strokeTextAttributes: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear, .foregroundColor: UIColor.white]
            attributedText.addAttributes(strokeTextAttributes, range: range)
            self.attributedText = attributedText
        }
    
}
