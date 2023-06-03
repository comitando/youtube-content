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
        var categoriesContent: [ProductListViewController.ViewContent] = []
        
        for (section, category) in categories.enumerated() {
            var items: [ProductCell.CellContent] = []
            
            for (index, product) in category.items.enumerated() {
                items.append(.init(indexPath: .init(row: index, section: section),
                                   quantityOnCart: cart.first(where: { $0.productId == product.id })?.quantity ?? 0,
                                   product: product))
            }
            
            categoriesContent.append(.init(name: category.name, items: items))
        }
        
        view?.showData(contentList: .init(categories: categoriesContent))
    }
    
    func updateCell(product: Product, cartItem: CartItem?, indexPath: IndexPath) {
        view?.updateCell(cellContent: .init(indexPath: indexPath,
                                            quantityOnCart: cartItem?.quantity ?? 0,
                                            product: product))
    }
}
