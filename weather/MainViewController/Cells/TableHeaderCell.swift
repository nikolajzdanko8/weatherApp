import UIKit

final class TableHeaderCell: UITableViewCell {
// MARK: - IBOutlet
    @IBOutlet var collectionView: UICollectionView!

// MARK: - Var
    var arrayCollectionView: [Hourly] = []
    var current: Current?
    
// MARK: - Let
    private let countCells = 12
    static let tableHeaderCellIdentifier = "TableHeaderCell"

// MARK: - Life cycle
    override func awakeFromNib() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CollectionCell.collectionCellIdentifier, bundle: nil), forCellWithReuseIdentifier: CollectionCell.collectionCellIdentifier)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addSubview(SeparatorManager.shared.setSeparatorLineFor(style: 1, width: UIApplication.shared.windows[0].frame.width))
        addSubview(SeparatorManager.shared.setSeparatorLineFor(style: 3, width: UIApplication.shared.windows[0].frame.width))
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension TableHeaderCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollectionView.count - 23
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        
        let array = arrayCollectionView[indexPath.item]
        cell.tempOfTheDayLabel.text = "\(Int(array.temp ?? Double()))˚"
        cell.setLabel()
        let sunRise = current?.sunrise?.addDailyDate(date: current?.sunrise ?? Int(), dateFormat: "HH")
        let dt = array.dt?.addDailyDate(date: array.dt ?? Int(), dateFormat: "HH")
        let sunSet = current?.sunset?.addDailyDate(date: current?.sunset ?? Int(), dateFormat: "HH")
        let sunSetHHmm = current?.sunset?.addDailyDate(date: current?.sunset ?? Int(), dateFormat: "HH:mm")
        let sunRiseHHmm = current?.sunrise?.addDailyDate(date: current?.sunrise ?? Int(), dateFormat: "HH:mm")
        
        for element in array.weather {
            if element.icon == "09d" || element.icon == "09n" || element.icon == "10d" || element.icon == "10n" || element.icon == "11d" || element.icon == "11n" {
                let x = array.rain?.oneHh ?? Double()
                cell.probabilityOfPrecipitation.text = "\(Int((x * 100)))%"
            } else if element.icon == "13d" || element.icon == "13n" {
                let x = array.snow?.oneHh ?? Double()
                cell.probabilityOfPrecipitation.text = "\(Int((x * 100)))%"
            } else {
                cell.probabilityOfPrecipitation.text = ""
            }
            cell.imageView.image = UIImage(named: element.icon ?? String())
        }
        
        if dt == sunRise {
            cell.imageView.image = UIImage(named: "sunRise")
            cell.tempOfTheDayLabel.text = "Восход солнца"
        } else if dt == sunSet {
            cell.imageView.image = UIImage(named: "sunSet")
            cell.tempOfTheDayLabel.text = "Заход солнца"
        }
        
        if indexPath.item == 0 {
            cell.hoursOfTheDayLabel.text = "Now"
        } else if  dt == sunRise {
            cell.hoursOfTheDayLabel.text = sunRiseHHmm
        } else if  dt == sunSet {
            cell.hoursOfTheDayLabel.text = sunSetHHmm
        } else {
            cell.hoursOfTheDayLabel.text = array.dt?.addDailyDate(date: array.dt ?? Int(), dateFormat: "HH")
        }
        return cell
    }
// MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let array = arrayCollectionView[indexPath.item]
        let sunSet = current?.sunset?.addDailyDate(date: current?.sunset ?? Int(), dateFormat: "HH")
        let sunRise = current?.sunrise?.addDailyDate(date: current?.sunrise ?? Int(), dateFormat: "HH")
        
        let dt = array.dt?.addDailyDate(date: array.dt ?? Int(Double()), dateFormat: "HH")
        if dt == sunRise {
            let frameCV = collectionView.frame
            let widthCell = frameCV.width / CGFloat(2.9)
            return CGSize(width: widthCell, height: collectionView.frame.height)
        } else if dt == sunSet {
            let frameCV = collectionView.frame
            let widthCell = frameCV.width / CGFloat(3.1)
            return CGSize(width: widthCell, height: collectionView.frame.height)
        } else if  indexPath.item == 0 {
            let frameCV = collectionView.frame
            let widthCell = frameCV.width / CGFloat(countCells)
            return CGSize(width: widthCell * 1.25, height: collectionView.frame.height)
        }
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        return CGSize(width: widthCell * 1.1, height: collectionView.frame.height)
    }
    
}
