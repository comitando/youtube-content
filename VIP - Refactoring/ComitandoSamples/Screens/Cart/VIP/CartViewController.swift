import UIKit

protocol CartViewControllerProtocol: AnyObject {
    func showData(cartItems: [CartItem])
    func updateCell(item: CartItem?)
}

final class CartViewController: UIViewController, UIGestureRecognizerDelegate {
    var interactor: CartInteractorProtocol?
    
    // MARK: - Private Properties
    
    private lazy var cartView: UIView = {
        let element = CartView()
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
        view = cartView
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
        navigationItem.title = Strings.cartTitle
        
        navigationItem.leftBarButtonItem = .init(image: Asset.Assets.iconBack.image,
                                                 style: .plain,
                                                 target: navigationController,
                                                 action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem?.tintColor = Asset.Colors.techGreen2.color
    }
}


// MARK: - CartViewControllerProtocol

extension CartViewController: CartViewControllerProtocol {
    func showData(cartItems: [CartItem]) {
        guard let view = cartView as? CartView else { return }
        view.setCartItems(cartItems: cartItems)
    }
    
    func updateCell(item: CartItem?) {
        guard let view = cartView as? CartView,
              let item else { return }
        view.updateCell(item: item)
    }
}

// MARK: - CartViewProtocol

extension CartViewController: CartViewProtocol {
    func didIncrement(cartItem: CartItem) {
        interactor?.didIncrement(cartItem: cartItem)
    }
    
    func didDecrement(cartItem: CartItem) {
        interactor?.didDecrement(cartItem: cartItem)
    }
}
