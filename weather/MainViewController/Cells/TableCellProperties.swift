import UIKit

final class TableCellProperties: UITableViewCell {
// MARK: - Variable
    static let TableCellPropertiesIdentifier = "TableCellProperties"
    
// MARK: - IBOutlet
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var sunRiseValueLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var sunSetValueLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var popValueLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windValueLabel: UILabel!
    @IBOutlet weak var fellsLikeLabel: UILabel!
    @IBOutlet weak var fellLikeValueLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var precipitationValueLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var visibilityValueLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var uvIndexValueLabel: UILabel!
    
    func configereCell(with object: Current?) {
        backgroundColor = .clear
        sunRiseLabel.textColor = .white
        sunSetLabel.textColor = .white
        popLabel.textColor = .white
        humidityLabel.textColor = .white
        windLabel.textColor = .white
        fellsLikeLabel.textColor = .white
        precipitationLabel.textColor = .white
        pressureLabel.textColor = .white
        visibilityLabel.textColor = .white
        uvIndexLabel.textColor = .white
        sunRiseValueLabel.textColor = .black
        sunSetValueLabel.textColor = .black
        popValueLabel.textColor = .black
        humidityValueLabel.textColor = .black
        windValueLabel.textColor = .black
        fellLikeValueLabel.textColor = .black
        precipitationValueLabel.textColor = .black
        pressureValueLabel.textColor = .black
        visibilityValueLabel.textColor = .black
        uvIndexValueLabel.textColor = .black
        sunRiseLabel.text = "ВОСХОД СОЛНЦА"
        sunRiseValueLabel.text = object?.sunrise?.addDailyDate(date: object?.sunrise ?? Int(), dateFormat: "HH:mm")
        
        if object?.snow?.oneHh != nil {
            popLabel.text = "ВЕРОЯТНОСТЬ СНЕГА"
            let x = object?.snow?.oneHh ?? Double()
            popValueLabel.text = "\(Int((x * 100) / 1.5))%"
        } else if object?.rain?.oneHh != nil {
            popLabel.text = "ВЕРОЯТНОСТЬ ДОЖДЯ"
            let x = object?.rain?.oneHh ?? Double()
            popValueLabel.text = "\(Int((x * 100) / 1.5))%"
        } else {
            popLabel.text = "ВЕРОЯТНОСТЬ ОСАДКОВ"
            popValueLabel.text = "0 %"
        }
        
        sunSetLabel.text = "ЗАХОД СОЛНЦА"
        sunSetValueLabel.text = object?.sunset?.addDailyDate(date: object?.sunset ?? Int(), dateFormat: "HH:mm")
        humidityLabel.text = "ВЛАЖНОСТЬ"
        humidityValueLabel.text = "\(object?.humidity ?? Int()) %"
        windLabel.text = "ВЕТЕР"
        windValueLabel.text = "з \(Int((object?.windSpeed ?? Double()) * Double(3.6))) км/ч"
        fellsLikeLabel.text = "ОЩУЩАЕТСЯ КАК"
        fellLikeValueLabel.text = "\(Int(object?.feelsLike ?? Double()))˚"
        precipitationLabel.text = "ОСАДКИ"
        precipitationValueLabel.text = "\((object?.clouds ?? Int()) ) см"
        pressureLabel.text = "ДАВЛЕНИЕ"
        pressureValueLabel.text = "\(object?.pressure ?? Int()) гПа"
        visibilityLabel.text = "ВИДИМОСТЬ"
        visibilityValueLabel.text = "\(Double(((object?.visibility ?? Int()) / 1000))) km"
        uvIndexLabel.text = "УФ-ИНДЕКС"
        uvIndexValueLabel.text = "\(Int(object?.uvi ?? Double()))"
    }
}
