import UIKit

final class CollectionCell: UICollectionViewCell {
// MARK: Variable
    static let collectionCellIdentifier = "CollectionCell"

// MARK: IBOutlet
    @IBOutlet weak var hoursOfTheDayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempOfTheDayLabel: UILabel!
    @IBOutlet weak var probabilityOfPrecipitation: UILabel!
    
    func setLabel() {
        hoursOfTheDayLabel.textColor = .black
        tempOfTheDayLabel.textColor = .black
        probabilityOfPrecipitation.textColor = .black
    }
}
