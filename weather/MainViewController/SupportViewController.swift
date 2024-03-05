import UIKit

final class SupportViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var myLabel: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delayPushController()
    }
}

    //MARK: - Private methods
private extension SupportViewController {
    func delayPushController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
