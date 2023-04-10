import UIKit

protocol ApplyDiscountInteractorProtocol {
    func didLoad()
    func applyDiscount(value: String)
}

class ApplyDiscountInteractor: ApplyDiscountInteractorProtocol {
    
    enum ApplyDiscountError {
        case invalidNumber
        case lessThanMinDiscountValue
        case higherThanMaxDiscountValue
    }

    var presenter: ApplyDiscountPresenterProtocol?
    
    let minDiscountValue: Int = 1
    let maxDiscountValue: Int = 30
    
    let productName: String = "Macbook Pro"
    let productPrice: Double = 12000
    
    func didLoad() {
        presenter?.showProductInfo(name: productName,
                                   price: productPrice,
                                   minDiscountValue: minDiscountValue,
                                   maxDiscountValue: maxDiscountValue)
    }
    
    func applyDiscount(value: String) {
        let validRange = (min: minDiscountValue,
                          max: maxDiscountValue)
        guard let number = Double(value) else {
            presenter?.showError(error: .invalidNumber,
                                 validRange: validRange)
            return
        }
        
        if number < Double(minDiscountValue) {
            presenter?.showError(error: .lessThanMinDiscountValue,
                                 validRange: validRange)
        } else if number > Double(maxDiscountValue) {
            presenter?.showError(error: .higherThanMaxDiscountValue,
                                 validRange: validRange)
        } else {
            presenter?.showDiscount(name: productName,
                                    price: productPrice,
                                    priceWithDiscount: productPrice - (productPrice * (number / 100)))
        }
    }
}
