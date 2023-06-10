import Foundation

protocol CartInteractorProtocol {
    func loadData()
    func didIncrement(cartItem: CartItem)
    func didDecrement(cartItem: CartItem)
}

final class CartInteractor {
    private let presenter: CartPresenterProtocol?
    
    private var cartItems: [CartItem]
    
    init(presenter: CartPresenterProtocol?, cartItems: [CartItem]) {
        self.presenter = presenter
        self.cartItems = cartItems
    }
}

// MARK: CartInteractorProtocol

extension CartInteractor: CartInteractorProtocol {
    func loadData() {
        presenter?.showData(cartItems: cartItems)
    }
        
    func didIncrement(cartItem: CartItem) {
        cartItem.incrementQuantity()
        presenter?.updateCell(cartItem: cartItem)
    }
    
    func didDecrement(cartItem: CartItem) {
        if cartItem.hasOnlyOne {
            cartItems.removeAll(where: { $0.product.id == cartItem.product.id })
            presenter?.showData(cartItems: cartItems)
        } else {
            cartItem.decrementQuantity()
            presenter?.updateCell(cartItem: cartItem)
        }
    }
}
