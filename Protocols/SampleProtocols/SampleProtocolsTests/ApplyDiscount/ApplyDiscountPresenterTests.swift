import XCTest
@testable import SampleProtocols

final class ApplyDiscountPresenterTests: XCTestCase {
    typealias SUT = ApplyDiscountPresenter
    
    private let viewControllerSpy = ApplyDiscountViewControllerSpy()

    func test_WhenCallShowProductInfo_ShouldCallShowProductInfoOnViewController() {
        let sut = makeSUT()
        sut.showProductInfo(name: "", price: 0.0, minDiscountValue: 1, maxDiscountValue: 30)
        XCTAssertEqual(viewControllerSpy.calledMethods, [.showProductInfo])
    }
    
    func test_WhenCallShowDiscount_ShouldCallShowDiscountOnViewController() {
        let sut = makeSUT()
        sut.showDiscount(name: "", price: 0.0, priceWithDiscount: 0.0)
        
        XCTAssertEqual(viewControllerSpy.calledMethods, [.showDiscount])
    }
    
    func test_WhenCallShowError_ShouldCallShowErrorOnViewController() {
        let sut = makeSUT()
        sut.showError(error: .invalidNumber, validRange: (min: 0, max: 0))
        sut.showError(error: .lessThanMinDiscountValue, validRange: (min: 0, max: 0))
        sut.showError(error: .higherThanMaxDiscountValue, validRange: (min: 0, max: 0))

        XCTAssertEqual(viewControllerSpy.calledMethods, [.showError, .showError, .showError])
    }
    
    private func makeSUT() -> SUT {
        let presenter = ApplyDiscountPresenter()
        presenter.viewController = viewControllerSpy
        
        return presenter
    }
}

class ApplyDiscountViewControllerSpy: ApplyDiscountViewControllerProtocol {
    
    enum Methods {
        case showProductInfo
        case showDiscount
        case showError
    }
    
    var calledMethods = [Methods]()
    
    func showProductInfo(product: String, discountInfo: String) {
        calledMethods.append(.showProductInfo)
    }
    
    func showDiscount(message: String) {
        calledMethods.append(.showDiscount)
    }
    
    func showError(message: String) {
        calledMethods.append(.showError)
    }
}
