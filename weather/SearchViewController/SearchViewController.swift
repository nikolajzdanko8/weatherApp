import UIKit

final class SearchViewController: UIViewController {
    
// MARK: - IBOutlet
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
// MARK: - Variable
    private var timer: Timer?
    private var array: [ModelCityes] = []
    private let manager = NetworkService()
    private var lonn: Double?
    private var latt: Double?
    private var highlight: String?
    private var tableLabel: String?
    
// MARK: - Life cyсle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
// MARK: - IBAction
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private methods
private extension SearchViewController {
// MARK: - setup SearchContoller and label
    private func setupSearchController() {
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
        label.text = "Город, индекс или название аэропорта"
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "http://api.weatherapi.com/v1/search.json?key=b2ecdacfd5b9493ebd3183320211903&q=\(searchText)"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false , block: { (_) in
            self.manager.modelCityesGetRequest(url: urlString) { [weak self] (data) in
                self?.array = data
                self?.highlight = searchText
                self?.tableView.reloadData()
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableSearchCell", for: indexPath) as? TableSearchCell else { return UITableViewCell() }
        let arrayCityes = array[indexPath.row]
        cell.highlight = highlight
        cell.configereCell(with: arrayCityes)
        return cell
    }
    
// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = UIStoryboard(name: "DetailStoryboard", bundle: nil).instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        controller.lat = array[indexPath.row].lat
        controller.lon = array[indexPath.row].lon
        present(controller, animated: true, completion: nil)
    }
}
