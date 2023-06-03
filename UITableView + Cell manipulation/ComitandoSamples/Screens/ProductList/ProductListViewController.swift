import UIKit

class ProductListViewController: UIViewController {
    // MARK: - Private Properties
    
    private lazy var productListView: UIView = {
        let element = ProductListView()
        element.translatesAutoresizingMaskIntoConstraints = true
        element.delegate = self
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
        view = productListView
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
        navigationBar.topItem?.title = Strings.listNavigationTitle
    }
}

// MARK: - ProductListViewProtocol

extension ProductListViewController: ProductListViewProtocol {
    func didSelect(product: Product) {
        let alertController = UIAlertController(
            title: "Item selecionado!",
            message: "Selecionou o produto: \(product.name)",
            preferredStyle: .alert
        )
       
        alertController.addAction(.init(title: "OK", style: .default) { (action) in })
        
        present(alertController, animated: true, completion: nil)
    }
    
    func didAddProduct(product: Product) {
        
    }
    
    func didIncrementProduct(product: Product) {
    
    }
    
    func didDecrementProduct(product: Product) {

    }
}
