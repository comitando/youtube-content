import UIKit

class ProductDetailViewController: UIViewController {
    // MARK: - Private Properties
    
    private lazy var productDetailView: UIView = {
        let element = ProductDetailView()
        element.translatesAutoresizingMaskIntoConstraints = true
        return element
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.Colors.spaceBlue1.color
        configureNavigation()
    }
    
    override func loadView() {
        super.loadView()
        view = productDetailView
    }
    
    
    // MARK: - Private Methods

    private func configureNavigation() {
        guard let navigationController else { return }
        
        navigationController.isNavigationBarHidden = false
        
        let navigationBar = navigationController.navigationBar
        navigationBar.barStyle = .black
        navigationBar.backgroundColor = Asset.Colors.spaceBlue1.color
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: Asset.Colors.techGreen2.color
        ]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.topItem?.title = Strings.navigationTitle
    }
}
