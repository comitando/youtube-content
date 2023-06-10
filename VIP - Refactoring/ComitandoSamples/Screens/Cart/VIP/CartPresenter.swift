import Foundation

protocol CartPresenterProtocol {
    func showData(cartItems: [CartItem])
    func updateCell(cartItem: CartItem?)
}

final class CartPresenter {
    private weak var view: CartViewControllerProtocol?
    
    init(view: CartViewControllerProtocol?) {
        self.view = view
    }
}

// MARK: CartPresenterProtocol

extension CartPresenter: CartPresenterProtocol {
    func showData(cartItems: [CartItem]) {
        view?.showData(cartItems: cartItems)
    }
    
    func updateCell(cartItem: CartItem?) {
        view?.updateCell(item: cartItem)
    }
}
