import UIKit

final class TableSearchCell: UITableViewCell {
// MARK: - IBOutlet
    @IBOutlet weak var cityLabel: UILabel!
    
// MARK: - Variable
    var highlight: String?
    
    func configereCell(with object: ModelCityes) {
        cityLabel.text = object.name
        cityLabel.setHighlightedText(value: object.name, highlight: highlight)
    }
}
