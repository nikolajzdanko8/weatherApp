import UIKit

final class TableCell: UITableViewCell {
// MARK: - IBOutlet
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!

// MARK: - Variable
    var imageTemp: UIImage?
    
// MARK: - Life cycle
    func configureGradient(image: UIImage) {
        switch image.pngData() {
        case  UIImage(named: "clear")?.pngData():
            self.addGradientBackground(firstColor: UIColor(red: 0.583, green: 0.8, blue: 1, alpha: 1), secondColor: UIColor(red: 0.872, green: 0.938, blue: 1, alpha: 1))
            print("clear")
        case  UIImage(named: "cloud")?.pngData() :
            self.addGradientBackground(firstColor: UIColor(red: 0.971, green: 0.986, blue: 1, alpha: 1), secondColor: UIColor(red: 0.679, green: 0.846, blue: 1, alpha: 1))
            print("cloud")
        case  UIImage(named: "mist")?.pngData() :
            self.mistWeatherGradient(view: self)
        case  UIImage(named: "rain")?.pngData() :
            self.rainWeatherGradient(view: self)
        case  UIImage(named: "snow")?.pngData() :
            self.snowWeatherGradient(view: self)
        case UIImage(named: "thunderStorm")?.pngData() :
            self.thunderstormWeatherGradient(view: self)
        case  UIImage(named: "mainly")?.pngData() :
            self.mainlyСloudyWeatherGradient(view: self)
        default:
            self.addGradientBackground(firstColor: .green, secondColor: .blue)
            print("11")
        }
    }
    
    func configure(with object: CustomStruct?) {
        labelCityName.text = object?.textName
        labelTemp.text = object?.textTemp
        labelDate.text = object?.dt?.addDailyDate(date: object?.dt ?? Int(), dateFormat: "HH:mm")

    }
}

extension UIView {
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
