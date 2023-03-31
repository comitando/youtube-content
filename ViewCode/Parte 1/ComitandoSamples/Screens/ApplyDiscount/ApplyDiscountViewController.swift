import UIKit

protocol ApplyDiscountViewControllerProtocol: AnyObject {
    func showProductInfo(product: String, discountInfo: String)
    func showDiscount(message: String)
    func showError(message: String)
}

class ApplyDiscountViewController: UIViewController {

    var interactor: ApplyDiscountInteractor?

    // MARK: - Private Properties
    
    private lazy var applyDiscountView: UIView & ApplyDiscountViewInputProtocol = {
        let element = ApplyDiscountView()
        element.translatesAutoresizingMaskIntoConstraints = true
        element.delegate = self
        return element
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        interactor?.didLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = applyDiscountView
    }
    
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ApplyDiscountInteractor()
        let presenter = ApplyDiscountPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension ApplyDiscountViewController: ApplyDiscountViewControllerProtocol {
    func showProductInfo(product: String, discountInfo: String) {
        applyDiscountView.setProductLabel(text: product)
        applyDiscountView.setInfoLabel(text: discountInfo)
    }
    
    func showDiscount(message: String) {
        applyDiscountView.showPriceWithDiscount(message: message)
    }
    
    func showError(message: String) {
        applyDiscountView.showErrorMessage(message: message)
    }
}

extension ApplyDiscountViewController: ApplyDiscountViewOutputProtocol {
    func applyDiscount(value: String) {
        interactor?.applyDiscount(value: value)
    }
}
