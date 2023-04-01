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
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        view = productDetailView
    }
}
