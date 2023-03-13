import XCTest
@testable import SampleProtocols

final class ApplyDiscountInteractorTests: XCTestCase {
    typealias SUT = ApplyDiscountInteractor
    
    private let presenterSpy = ApplyDiscountPresenterSpy()

    func test_WhenCallDidLoad_ShouldCallShowProductInfo() {
        let sut = makeSUT()
        sut.didLoad()
        
        XCTAssertEqual(presenterSpy.calledMethods, [.showProductInfo])
    }
    
    func test_WhenCallApplyDiscount_WithInvalidNumber_ShouldCallShowError() {
        let sut = makeSUT()
        sut.applyDiscount(value: "ERROR")
        
        XCTAssertEqual(presenterSpy.calledMethods, [.showError])
    }
    
    func test_WhenCallApplyDiscount_WithNumberLowerThanMinimum_ShouldCallShowError() {
        let sut = makeSUT()
        sut.applyDiscount(value: "0")
        
        XCTAssertEqual(presenterSpy.calledMethods, [.showError])
    }
    
    func test_WhenCallApplyDiscount_WithNumberHigherThanMaximum_ShouldCallShowError() {
        let sut = makeSUT()
        sut.applyDiscount(value: "50")
        
        XCTAssertEqual(presenterSpy.calledMethods, [.showError])
    }
    
    func test_WhenCallApplyDiscount_WithValidNumber_ShowCallShowDiscount() {
        let sut = makeSUT()
        sut.applyDiscount(value: "25")
        
        XCTAssertEqual(presenterSpy.calledMethods, [.showDiscount])
    }
    
    private func makeSUT() -> SUT {
        let interactor = ApplyDiscountInteractor()
        interactor.presenter = presenterSpy
        
        return interactor
    }
}

class ApplyDiscountPresenterSpy: ApplyDiscountPresenterProtocol {
    
    enum Methods {
        case showProductInfo
        case showDiscount
        case showError
    }
    
    var calledMethods = [Methods]()
    
    func showProductInfo(name: String,
                         price: Double,
                         minDiscountValue: Int,
                         maxDiscountValue: Int) {
        calledMethods.append(.showProductInfo)
    }
    
    func showDiscount(name: String,
                      price: Double,
                      priceWithDiscount: Double) {
        calledMethods.append(.showDiscount)
    }
    
    func showError(error: SampleProtocols.ApplyDiscountInteractor.ApplyDiscountError,
                   validRange: (min: Int, max: Int)) {
        calledMethods.append(.showError)
    }
}
