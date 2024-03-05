import UIKit
import CoreLocation
import MapKit

final class MyView: UIView {
    
// MARK: - IBOutlet
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var tempCurrentLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    @IBOutlet weak var myConstaint: NSLayoutConstraint!
    @IBOutlet weak var topCityConstraint: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
// MARK: - Variable
    var arrayCollectionView: [Hourly] = []
    var current: Current?
    var arrayTableView: [Daily] = []
    var dayliTemp: Temp?
    var long: Double?
    var lat: Double?
    var model: Model?
    let locationManager = CLLocationManager()
    let request = NetworkService()
    var dailyPop: Double?
    var currentDt: Int?
    
// MARK: - Life cyсle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
}

extension MyView {
// MARK: - Create xib
    class func instanceFromNib() -> MyView {
        return UINib(nibName: "MyView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? MyView ?? MyView()
    }
    
// MARK: - Setup TableView and register for cells
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TableDayliCell.tableDayliCellIdentifier, bundle: nil), forCellReuseIdentifier: TableDayliCell.tableDayliCellIdentifier)
        tableView.register(UINib(nibName: TableCellDescription.TableCellDescriptionIdentifier, bundle: nil), forCellReuseIdentifier: TableCellDescription.TableCellDescriptionIdentifier)
        tableView.register(UINib(nibName: TableCellProperties.TableCellPropertiesIdentifier, bundle: nil), forCellReuseIdentifier: TableCellProperties.TableCellPropertiesIdentifier)
        tableView.register(UINib(nibName: TableCellMap.TableCellMapIdentifier, bundle: nil), forCellReuseIdentifier: TableCellMap.TableCellMapIdentifier)
        tableView.register(UINib(nibName: TableHeaderCell.tableHeaderCellIdentifier, bundle: nil), forCellReuseIdentifier: TableHeaderCell.tableHeaderCellIdentifier)
    }
    
}
// MARK: - UITableViewDataSource
extension MyView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableHeaderCell") as? TableHeaderCell else { return UIView() }
        cell.arrayCollectionView = arrayCollectionView
        cell.current = current
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTableView.count + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < arrayTableView.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableDayliCell", for: indexPath) as? TableDayliCell else { return UITableViewCell() }
            let arrayTable = arrayTableView[indexPath.row]
            cell.configureCell(with: arrayTable)
            return cell
        } else if indexPath.row < arrayTableView.count + 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellDescription", for: indexPath) as? TableCellDescription else { return UITableViewCell() }
            cell.current = current
            cell.dayliTemp = dayliTemp
            cell.labelDescription = labelDescription
            cell.configureCell()
            return cell
        } else if indexPath.row < arrayTableView.count + 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellProperties", for: indexPath) as? TableCellProperties else { return UITableViewCell() }
            cell.configereCell(with: current)
            return cell
        } else if indexPath.row < arrayTableView.count + 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellMap", for: indexPath) as? TableCellMap else { return UITableViewCell() }
            cell.lat = lat
            cell.long = long
            cell.configureCell(with: model)
            return cell
        }
        return UITableViewCell()
    }
    
// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < arrayTableView.count {
            return 40
        } else if indexPath.row < arrayTableView.count + 1 {
            return 90
        } else if indexPath.row < arrayTableView.count + 2 {
            return 280
        } else if indexPath.row < arrayTableView.count + 3 {
            return 70
        }
        return CGFloat()
    }
    
// MARK: - ScrollViewDelegate
     func scrollViewDidScroll (_ scrollView: UIScrollView) {
        scrollView.setupMaskCellForScrollView(scrollView: scrollView, tableView: tableView)
        scrollView.setupScrollView(scrollView: scrollView, myConstaint: myConstaint, topCityConstraint: topCityConstraint, tempCurrentLabel: tempCurrentLabel, maxMinTempLabel: maxMinTempLabel, imageView: imageView)
    }
}
