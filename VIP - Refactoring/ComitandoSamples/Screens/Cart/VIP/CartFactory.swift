import UIKit

struct CartFactory {
    static func build(cartItems: [CartItem]) -> UIViewController {
        let view = CartViewController()
        let presenter = CartPresenter(view: view)
        let interactor = CartInteractor(presenter: presenter, cartItems: cartItems)
        
        view.interactor = interactor
        
        return view
    }
}
