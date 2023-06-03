import Foundation

protocol ProductListInteractorProtocol {
    func loadData()
    func didSelect(indexPath: IndexPath)
    func didAddProduct(indexPath: IndexPath)
    func didIncrementProduct(indexPath: IndexPath)
    func didDecrementProduct(indexPath: IndexPath)
}

final class ProductListInteractor {
    private let presenter: ProductListPresenterProtocol?
    
    private var cart: [CartItem] = []
    
    // Usado enquanto não temos a camada de REDE implementada
    private var mock = Mock()
    
    init(presenter: ProductListPresenterProtocol?) {
        self.presenter = presenter
    }
    
    private func getProduct(indexPath: IndexPath) -> Product? {
        mock.categories[indexPath.section].items[indexPath.row]
    }
    
    private func getCartItem(productId: String) -> CartItem? {
        cart.first(where: { $0.productId == productId } )
    }
}

// MARK: ProductListInteractorProtocol

extension ProductListInteractor: ProductListInteractorProtocol {
    func loadData() {
        presenter?.showData(categories: mock.categories, cart: cart)
    }
    
    func didSelect(indexPath: IndexPath) {
        
    }
    
    func didAddProduct(indexPath: IndexPath) {
        guard let product = getProduct(indexPath: indexPath) else { return }
        cart.append(.init(productId: product.id, quantity: 1))

        guard let cartItem = getCartItem(productId: product.id) else { return }
        presenter?.updateCell(product: product, cartItem: cartItem, indexPath: indexPath)
    }
    
    func didIncrementProduct(indexPath: IndexPath) {
        guard let product = getProduct(indexPath: indexPath),
              let index = cart.firstIndex(where: { $0.productId == product.id }) else {
            return
        }
        cart[index].incrementQuantity()

        guard let cartItem = getCartItem(productId: product.id) else { return }
        presenter?.updateCell(product: product, cartItem: cartItem, indexPath: indexPath)
    }
    
    func didDecrementProduct(indexPath: IndexPath) {
        guard let product = getProduct(indexPath: indexPath),
              let index = cart.firstIndex(where: { $0.productId == product.id }) else {
            return
        }
        
        if cart[index].hasOnlyOne {
            cart.remove(at: index)
            presenter?.updateCell(product: product, cartItem: nil, indexPath: indexPath)
        } else {
            cart[index].decrementQuantity()
            presenter?.updateCell(product: product, cartItem: cart[index], indexPath: indexPath)
        }
    }
}
