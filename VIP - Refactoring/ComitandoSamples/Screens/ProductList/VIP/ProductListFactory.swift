import UIKit

struct ProductListFactory {
    static func build() -> UIViewController {
        let view = ProductListViewController()
        let presenter = ProductListPresenter(view: view)
        let interactor = ProductListInteractor(presenter: presenter)
        
        view.interactor = interactor
        
        return view
    }
}
