import UIKit

protocol ProductListViewControllerProtocol: AnyObject {
    func showData(contentList: ProductListViewController.ViewContentList)
    func updateCell(cellContent: ProductCell.CellContent, indexPath: IndexPath)
    func showViewController(viewController: UIViewController)
}

final class ProductListViewController: UIViewController {
    struct ViewContent {
        let name: String
        var items: [ProductCell.CellContent]
    }

    struct ViewContentList {
        var categories: [ViewContent]
    }
    
    var interactor: ProductListInteractorProtocol?
    
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
        interactor?.loadData()
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
        navigationItem.title = Strings.listNavigationTitle
        
        navigationItem.rightBarButtonItem = .init(image: Asset.Assets.cartFill.image,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(showCart))
        navigationItem.rightBarButtonItem?.tintColor = Asset.Colors.techGreen2.color
    }
    
    @objc
    private func showCart() {
        interactor?.showCart()
    }
}


// MARK: - ProductListViewControllerProtocol

extension ProductListViewController: ProductListViewControllerProtocol {
    func showData(contentList: ViewContentList) {
        guard let view = productListView as? ProductListView else { return }
        view.setContent(content: contentList)
    }
    
    func updateCell(cellContent: ProductCell.CellContent, indexPath: IndexPath) {
        guard let view = productListView as? ProductListView else { return }
        view.updateCell(cellContent: cellContent, indexPath: indexPath)
    }
}

// MARK: - ProductListViewProtocol

extension ProductListViewController: ProductListViewProtocol {
    func didSelect(indexPath: IndexPath) {
        interactor?.didSelect(indexPath: indexPath)
    }
    
    func didAddProduct(product: Product) {
        interactor?.didAddProduct(product: product)
    }
    
    func didIncrementProduct(product: Product) {
        interactor?.didIncrementProduct(product: product)
    }
    
    func didDecrementProduct(product: Product) {
        interactor?.didDecrementProduct(product: product)
    }
    
    func showViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
