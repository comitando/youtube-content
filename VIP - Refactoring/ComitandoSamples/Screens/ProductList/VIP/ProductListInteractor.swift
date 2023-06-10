import Foundation

protocol ProductListInteractorProtocol {
    func loadData()
    func didSelect(indexPath: IndexPath)
    func didAddProduct(product: Product)
    func didIncrementProduct(product: Product)
    func didDecrementProduct(product: Product)
    func showCart()
}

final class ProductListInteractor {
    private let presenter: ProductListPresenterProtocol?
    
    private var cart: [CartItem] = []
    
    // Usado enquanto não temos a camada de REDE implementada
    private var mock = Mock()
    
    init(presenter: ProductListPresenterProtocol?) {
        self.presenter = presenter
    }
    
    private func getProduct(product: Product) -> Product? {
        mock.categories.compactMap { $0.items.first(where: { $0.id == product.id }) }.first
    }
    
    private func getProductIndexPath(product: Product) -> IndexPath? {
        var indexPath: IndexPath?
        
        for (section, category) in mock.categories.enumerated() {
            for (index, productItem) in category.items.enumerated() {
                if productItem.id == product.id {
                    indexPath = .init(row: index, section: section)
                }
            }
        }
        
        return indexPath
    }
    
    private func getCartItem(productId: String) -> CartItem? {
        cart.first(where: { $0.product.id == productId } )
    }
}

// MARK: ProductListInteractorProtocol

extension ProductListInteractor: ProductListInteractorProtocol {
    func loadData() {
        presenter?.showData(categories: mock.categories, cart: cart)
    }
    
    func didSelect(indexPath: IndexPath) {
        showCart()
    }
    
    func didAddProduct(product: Product) {
        cart.append(.init(product: product, quantity: 1))

        guard let cartItem = getCartItem(productId: product.id),
              let indexPath = getProductIndexPath(product: product) else { return }
        presenter?.updateCell(product: product,
                              cartItem: cartItem,
                              indexPath: indexPath)
    }
    
    func didIncrementProduct(product: Product) {
        guard let cartItem = getCartItem(productId: product.id),
              let indexPath = getProductIndexPath(product: product) else { return }
        
        cartItem.incrementQuantity()

        presenter?.updateCell(product: product,
                              cartItem: cartItem,
                              indexPath: indexPath)
    }
    
    func didDecrementProduct(product: Product) {
        guard let cartItem = getCartItem(productId: product.id),
              let indexPath = getProductIndexPath(product: product) else { return }
        
        if cartItem.hasOnlyOne {
            cart.removeAll(where: { $0.product.id == product.id })
            presenter?.updateCell(product: product,
                                  cartItem: nil,
                                  indexPath: indexPath)
        } else {
            cartItem.decrementQuantity()
            presenter?.updateCell(product: product,
                                  cartItem: cartItem,
                                  indexPath: indexPath)
        }
    }
    
    func showCart() {
        presenter?.showCart(cartItems: cart)
    }
}
