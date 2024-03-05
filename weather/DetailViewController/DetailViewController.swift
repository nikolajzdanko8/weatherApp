import UIKit
import CoreLocation

final class DetailViewController: UIViewController, CLLocationManagerDelegate {
// MARK: - IBOutlet
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonAdd: UIButton!
    
// MARK: - Variable
    var lon: Double?
    var lat: Double?
    private let locationManager = CLLocationManager()
    private let request = NetworkService()
    var longitude: Double?
    var latitude: Double?
    private var dailyPop: Double?
    private var rainOrSnow: String?
    var currentDt: Int?
    
    lazy var myView: MyView = {
        var myView = MyView()
        myView = MyView.instanceFromNib()
        myView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(myView)
        return myView
    }()
    
// MARK: - Life cyсle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.addSubview(buttonCancel)
        myView.addSubview(buttonAdd)
        setupLocation()
    }
    
// MARK: - IBAction
    @IBAction func actionСancellation(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        let dictionary = [
            "lat": lat ?? Double(),
            "lon": lon ?? Double(),
            "currentDt": currentDt ?? Int()
        ] as [String: Any]
        NotificationCenter.default.post(name: NSNotification.Name("location"), object: nil, userInfo: dictionary)
        self.presentingViewController?
            .presentingViewController?
            .dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController {
// MARK: - setup location
    func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitude = location.latitude
        longitude = location.longitude
        manager.stopUpdatingLocation()
        getRequest()
    }
    
    private func getRequest() {
        myView.request.getRequest(url: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat ?? Double())&lon=\(lon ?? Double())&units=metric&appid=22bde89beaa3c94eb6848745aa74d729") { [weak self] (data) in
            guard let self = self else { return }
            self.currentDt = data.current.dt
            self.myView.nameCityLabel.text = data.timezone
            self.myView.tempCurrentLabel.text = "\(Int(data.current.temp ?? Double()))˚"
            for element in data.current.weather {
                self.myView.labelDescription.text = element.description
                switch element.main {
                case "Clear":
                    self.myView.imageView.image = UIImage(named: "clear")
                    self.view.clearWeatherGradient(view: self.view)
                case "Clouds":
                    self.myView.imageView.image = UIImage(named: "cloud")
                    self.view.cloudsWeatherGradient(view: self.view)
                case _ where element.main == "Mist" || element.main == "Smoke" || element.main == "Haze" || element.main == "Dust" || element.main == "Fog" || element.main == "Sand" || element.main == "Ash" || element.main == "Squall" || element.main == "Tornado":
                    self.myView.imageView.image = UIImage(named: "mist")
                    self.view.mistWeatherGradient(view: self.view)
                case _ where element.main == "Rain" || element.main == "Drizzle":
                    self.myView.imageView.image = UIImage(named: "rain")
                    self.view.rainWeatherGradient(view: self.view)
                case "Snow":
                    self.myView.imageView.image = UIImage(named: "snow")
                    self.view.snowWeatherGradient(view: self.view)
                case "Thunderstorm":
                    self.myView.imageView.image = UIImage(named: "thunderStorm")
                    self.view.thunderstormWeatherGradient(view: self.view)
                case "few clouds":
                    self.myView.imageView.image = UIImage(named: "mainly")
                    self.view.mainlyСloudyWeatherGradient(view: self.view)
                default:
                    break
                }
            }
            for element in data.daily {
                self.myView.maxMinTempLabel.text = "Max: \(Int(element.temp?.max ?? Double()))˚, min: \(Int(element.temp?.min ?? Double()))˚"
                self.myView.dayliTemp = element.temp
                self.dailyPop = element.pop
            }
            self.myView.model = data
            self.myView.current = data.current
            self.myView.arrayCollectionView = data.hourly
            self.myView.arrayTableView = data.daily
            self.myView.tableView.reloadData()
        }
    }
}
    
extension Notification.Name {
    static let singleNotification = Notification.Name("singleNotification")
}
    
