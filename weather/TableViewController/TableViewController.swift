import UIKit
import Lottie

final class TableViewController: UIViewController {
    
// MARK: - IBOutlet
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableViewConstraint: NSLayoutConstraint!
    
// MARK: - Variable
    var lon: Double?
    var lat: Double?
    var model: Model?
    let request = NetworkService()
    var array: [CustomStruct] = []
    var current: Current?
    var currentDt: Int?
    var completion: ((Double?, Double?, UIView?) -> Void)?
    var temp: String?
    var imageWeather: UIImage?
    private var viewForTalbe: UIView?

// MARK: - Life cyсle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReseived), name: NSNotification.Name("location"), object: nil)
    }
    
// MARK: - IBAction
    @IBAction func getSearchAction(_ sender: UIButton) {
        guard let controller = UIStoryboard(name: "SearchStoryboard", bundle: nil).instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func actionSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            for element in array {
                let tc = "\(Int(Double(5.0 / 9.0) * ((Double(element.textTemp ?? String()) ?? Double()) - Double(32))))"
                element.textTemp = tc
            }
        case 1:
            for element in array {
                let tf = "\(Int(Double(9.0 / 5.0) * (Double(element.textTemp ?? String()) ?? Double()) + Double(32)))"
                element.textTemp = tf
            }
        default:
            break
        }
        tableView.reloadData()
    }
    
    @IBAction func getUrlButtonAction(_ sender: UIButton) {
        guard let url = URL(string: "https://openweathermap.org") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - Private methods
private extension TableViewController {
    
// MARK: - notification Reseived
    @objc func notificationReseived(notification: Notification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let lattitude = dict["lat"] as? Double {
                lat = lattitude
            }
            if let longitude = dict["lon"] as? Double {
                lon = longitude
            }
            if let dt = dict["currentDt"] as? Int {
                currentDt = dt
            }
        }
        getRequest()
    }

    func getRequest() {
        request.getRequest(url: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat ?? Double())&lon=\(lon ?? Double())&units=metric&appid=22bde89beaa3c94eb6848745aa74d729") { [weak self] (data) in
            guard let self = self else { return }
            for element in data.current.weather {
                switch element.main {
                case "Clear":
                    self.imageWeather = UIImage(named: "clear")
                case "Clouds":
                    self.imageWeather = UIImage(named: "cloud")
                case _ where element.main == "Mist" || element.main == "Smoke" || element.main == "Haze" || element.main == "Dust" || element.main == "Fog" || element.main == "Sand" || element.main == "Ash" || element.main == "Squall" || element.main == "Tornado":
                    self.imageWeather = UIImage(named: "mist")
                case _ where element.main == "Rain" || element.main == "Drizzle":
                    self.imageWeather = UIImage(named: "rain")
                case "Snow":
                    self.imageWeather = UIImage(named: "snow")
                case "Thunderstorm":
                    self.imageWeather = UIImage(named: "thunderStorm")
                case "few clouds":
                    self.imageWeather = UIImage(named: "mainly")
                default:
                    break
                }
            }
            self.model = data
            self.current = data.current
            let object = CustomStruct(lat: self.lat ?? Double(), lon: self.lon ?? Double(), image: self.imageWeather ?? UIImage(), textTemp: "\(Int(self.current?.temp ?? Double()))", textName: self.model?.timezone, dt: self.currentDt ?? Int())
            if self.array.count >= 1 {
                self.heightTableViewConstraint.constant += 95
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
            self.array.append(object)
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else  { return UITableViewCell() }
        cell.imageTemp = imageWeather
        let arrayTable = array[indexPath.row]
        cell.imageWeather?.image = arrayTable.image
        cell.configure(with: arrayTable)
        return cell
    }

// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(lat, lon, viewForTalbe)
        navigationController?.popViewController(animated: true)
    }
}
