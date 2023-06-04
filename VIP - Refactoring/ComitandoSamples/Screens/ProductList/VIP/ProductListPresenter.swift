import Foundation

protocol ProductListPresenterProtocol {
    func showData(categories: [Category], cart: [CartItem])
    func updateCell(product: Product, cartItem: CartItem?, indexPath: IndexPath)

}

final class ProductListPresenter {
    private weak var view: ProductListViewControllerProtocol?
    
    init(view: ProductListViewControllerProtocol?) {
        self.view = view
    }
}

// MARK: ProductListPresenterProtocol

extension ProductListPresenter: ProductListPresenterProtocol {
    func showData(categories: [Category], cart: [CartItem]) {
        view?.showData(contentList:
            .init(categories: categories.map { category in
                .init(name: category.name, items: category.items.map { product in
                    .init(quantityOnCart: cart.first(where: { $0.productId == product.id })?.quantity ?? 0, product: product)
                })
            })
        )
    }
    
    func updateCell(product: Product, cartItem: CartItem?, indexPath: IndexPath) {
        view?.updateCell(cellContent: .init(quantityOnCart: cartItem?.quantity ?? 0, product: product),
                         indexPath: indexPath)
    }
}
