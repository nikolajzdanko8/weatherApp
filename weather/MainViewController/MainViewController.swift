import UIKit
import CoreLocation
import MapKit

final class MainViewController: UIViewController {
// MARK: - IBOutlet
    @IBOutlet weak var viewForButton: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
// MARK: - Variable
    private let locationManager = CLLocationManager()
    private let networkService = NetworkService()
    private var long: Double?
    private var lat: Double?
    private var longitude: Double?
    private var latitude: Double?
    private var dailyPop: Double?
    private var rainOrSnow: String?
    private var array: [CustomStruct] = []
    private var myView3 = MyView()
    private var views: [UIView] = []
    private var imageForWeather: UIImage?
    private let numberForHeight: CGFloat = 1.065
    
    // MARK: - UI
    private lazy var myView: MyView = {
        var myView = MyView()
        myView = MyView.instanceFromNib()
        myView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / numberForHeight)
        view.addSubview(myView)
        return myView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height / numberForHeight)
        for i in 0..<views.count {
            scrollView.addSubview(views[i])
            views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height / numberForHeight)
        }
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = views.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapHandler), for: .touchUpInside)
        return pageControl
    }()
    
// MARK: - Lifecycle function
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupLocation()
        view.backgroundColor = .white
        views.append(myView)
        view.addSubview(scrollView)
        scrollView.edgeTo(view: view)
        view.addSubview(pageControl)
        pageControl.pinTo(view)
        self.view.bringSubviewToFront(viewForButton)
    }
    
// MARK: - IBAction
    @IBAction func buttonAction(_ sender: UIButton) {
        guard let controller = UIStoryboard(name: "TableStoryboard", bundle: nil).instantiateViewController(identifier: "TableViewController") as? TableViewController else { return }
        controller.array = array
        controller.completion = { [weak self] lat, lon, view in
            guard let self = self else { return }
            self.latitude = lat
            self.longitude = lon
            self.view = view
            self.getRequest(myViewXib: self.myView3, lat: self.latitude ?? Double(), lon: self.longitude ?? Double())
        }
        setupForNextViewInPageControl()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func actionOpenWeather(_ sender: UIButton) {
        guard let url = URL(string: "https://openweathermap.org") else { return }
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func pageControlTapHandler(sender: UIPageControl) {
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
}

// MARK: - Private methods
private extension MainViewController {
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getRequest(myViewXib: MyView, lat: Double?, lon: Double?) {
        myViewXib.request.getRequest(url: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat ?? Double())&lon=\(lon ?? Double())&units=metric&appid=22bde89beaa3c94eb6848745aa74d729") { [weak self] (data) in
            guard let self = self else { return }
            self.activityIndicator.isHidden = true
            self.myView.isHidden = false
            self.viewForButton.isHidden = false
            self.pageControl.isHidden = false
            self.activityIndicator.stopAnimating()
            myViewXib.nameCityLabel.text = data.timezone
            myViewXib.tempCurrentLabel.text = "\(Int(data.current.temp ?? Double()))˚"
            for element in data.current.weather {
                myViewXib.labelDescription.text = element.description
                switch element.main {
                case "Clear":
                    myViewXib.imageView.image = UIImage(named: "clear")
                    self.view.clearWeatherGradient(view: self.view)
                case "Clouds":
                    myViewXib.imageView.image = UIImage(named: "cloud")
                    self.view.cloudsWeatherGradient(view: self.view)
                case _ where element.main == "Mist" || element.main == "Smoke" || element.main == "Haze" || element.main == "Dust" || element.main == "Fog" || element.main == "Sand" || element.main == "Ash" || element.main == "Squall" || element.main == "Tornado":
                    myViewXib.imageView.image = UIImage(named: "mist")
                    self.view.mistWeatherGradient(view: self.view)
                case _ where element.main == "Rain" || element.main == "Drizzle":
                    myViewXib.imageView.image = UIImage(named: "rain")
                    self.view.rainWeatherGradient(view: self.view)
                case "Snow":
                    myViewXib.imageView.image = UIImage(named: "snow")
                    self.view.snowWeatherGradient(view: self.view)
                case "Thunderstorm":
                    myViewXib.imageView.image = UIImage(named: "thunderStorm")
                    self.view.thunderstormWeatherGradient(view: self.view)
                case "few clouds":
                    myViewXib.imageView.image = UIImage(named: "mainly")
                    self.view.mainlyСloudyWeatherGradient(view: self.view)
                default:
                    break
                }
            }
            for element in data.daily {
                myViewXib.maxMinTempLabel.text =
                "Max: \(Int(element.temp?.max ?? Double()))˚, min: \(Int(element.temp?.min ?? Double()))˚"
                myViewXib.dayliTemp = element.temp
                self.dailyPop = element.pop
            }
            myViewXib.currentDt = data.current.dt 
            myViewXib.model = data
            myViewXib.current = data.current
            myViewXib.arrayCollectionView = data.hourly
            myViewXib.arrayTableView = data.daily
            let object = CustomStruct(lat: lat ?? Double(), lon: lon ?? Double(), image: myViewXib.imageView.image, textTemp: "\(Int(myViewXib.current?.temp ?? Double()))", textName: "Моя геопозиция", dt: myViewXib.currentDt ?? Int())
            self.array.append(object)
            myViewXib.tableView.reloadData()
        }
    }
    
    func setupForNextViewInPageControl() {
        myView3 = MyView.instanceFromNib()
        views.append(myView3)
        pageControl.numberOfPages = self.views.count
        scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(self.views.count), height: self.view.frame.height / numberForHeight)
        myView3.frame = CGRect(x: self.view.frame.width * CGFloat(self.views.count - 1), y: 0, width: self.view.frame.width, height: self.view.frame.height / numberForHeight)
        scrollView.addSubview(myView3)
    }
}

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        lat = location.latitude
        long = location.longitude
        manager.stopUpdatingLocation()
        self.activityIndicator.isHidden = false
        self.myView.isHidden = true
        self.viewForButton.isHidden = true
        self.pageControl.isHidden = true
        self.activityIndicator.startAnimating()
        getRequest(myViewXib: myView, lat: lat ?? Double(), lon: long ?? Double())
    }
}

// MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
