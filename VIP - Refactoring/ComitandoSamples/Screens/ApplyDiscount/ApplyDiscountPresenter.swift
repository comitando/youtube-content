import UIKit

protocol ApplyDiscountPresenterProtocol {
    func showProductInfo(name: String,
                         price: Double,
                         minDiscountValue: Int,
                         maxDiscountValue: Int)
    func showDiscount(name: String,
                      price: Double,
                      priceWithDiscount: Double)
    func showError(error: ApplyDiscountInteractor.ApplyDiscountError,
                   validRange: (min: Int, max: Int))
}

class ApplyDiscountPresenter: ApplyDiscountPresenterProtocol {
    weak var viewController: ApplyDiscountViewControllerProtocol?
    
    func showProductInfo(name: String,
                         price: Double,
                         minDiscountValue: Int,
                         maxDiscountValue: Int) {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let productText = "\(name)\n\(formatter.string(from: price as NSNumber)!)"
        let discountInfoText = "Informe um valor entre \(minDiscountValue) e \(maxDiscountValue)"
        
        viewController?.showProductInfo(product: productText,
                                        discountInfo: discountInfoText)
    }
    
    
    func showDiscount(name: String,
                      price: Double,
                      priceWithDiscount: Double) {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let message = "\(name)\nde: \(formatter.string(from: price as NSNumber)!)\npor: \(formatter.string(from: priceWithDiscount as NSNumber)!)"
        viewController?.showDiscount(message: message)
    }

    func showError(error: ApplyDiscountInteractor.ApplyDiscountError,
                   validRange: (min: Int, max: Int)) {
        switch error {
        case .invalidNumber:
            viewController?.showError(message: "Informe um número válido")
        case .lessThanMinDiscountValue:
            viewController?.showError(message: "Informe um número maior do que \(validRange.min)")
        case .higherThanMaxDiscountValue:
            viewController?.showError(message: "Informe um número menor do que \(validRange.max)")
        }
    }
}
