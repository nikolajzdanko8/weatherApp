import UIKit
import MapKit

final class TableCellMap: UITableViewCell {
    
// MARK: - IBOutlet
    @IBOutlet weak var weatherName: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    
// MARK: - Var
    var long: CLLocationDegrees?
    var lat: CLLocationDegrees?
    static let TableCellMapIdentifier = "TableCellMap"

// MARK: - Life cycle
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(SeparatorManager.shared.setSeparatorLineFor(style: 1, width: bounds.size.width))
    }
    
    func configureCell(with object: Model?) {
        backgroundColor = .clear
        weatherName.textColor = .black
        buttonLabel.setTitleColor(.black, for: .normal)
        getUnderLine()
        weatherName.text = "Погода - \(object?.timezone ?? String())"
    }
    
    func getUnderLine() {
        let attributes = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(string: "Открыть в Картах", attributes: attributes)
        buttonLabel.setAttributedTitle(attributeString, for: .normal)
      
    }
    
    @IBAction func actionGetMap(_ sender: UIButton) {
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(lat ?? CLLocationDegrees(), long ?? CLLocationDegrees())
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "I'm here"
        mapItem.openInMaps(launchOptions: options)
    }
}
