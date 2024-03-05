import UIKit

final class TableDayliCell: UITableViewCell {
// MARK: - Variable
    static let tableDayliCellIdentifier = "TableDayliCell"

// MARK: - IBOutlet
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var tempLeftLabel: UILabel!
    @IBOutlet weak var tempRightLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    
    func configureCell(with object: Daily) {
        popLabel.textColor = .black
        dayOfWeekLabel.textColor = .black
        tempLeftLabel.textColor = .black
        tempRightLabel.textColor = .black
        backgroundColor = .clear
        
        dayOfWeekLabel.text = object.dt?.addDailyDate(date: object.dt ?? Int(), dateFormat: "EEEE" )
        tempLeftLabel.text = "\(Int(object.temp?.day ?? Double()))"
        tempRightLabel.text = "\(Int(object.temp?.night ?? Double()))"
        for element in object.weather {
            if element.icon == "09d" || element.icon == "09n" || element.icon == "10d" || element.icon == "10n" || element.icon == "11d" || element.icon == "11n"{
                let x = object.rain ?? Double()
                popLabel.text = "\(Int((x * 100)))%"
            } else if element.icon == "13d" || element.icon == "13n" {
                let x = object.snow ?? Double()
                popLabel.text = "\(Int((x * 100)))%"
            } else {
                popLabel.text = ""
            }
        }
        for element in object.weather {
            imageLabel.image = UIImage(named: element.icon ?? String())
        }
    }
}
