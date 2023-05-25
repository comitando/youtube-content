import UIKit
import SDUI
import Coordinator

public final class CDBCoodinator: Coordinator {
    
    public var parent: Coordinator?
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        listView()
    }
    
    public func finish() {
        navigationController.popToRootViewController(animated: true)
    }
    
}

extension CDBCoodinator {
    func listView() {
        let controller = CDBListViewFactory().makeBuilder(router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func pushDetail() {
        let controller = CDBDetailViewFactory().makeBuilder(router: self)
        navigationController.pushViewController(controller, animated: true)
    }

    func pushIinvestmentValue() {
        let controller = CDBInvestmentViewFactory().makeBuilder(router: self)
        navigationController.pushViewController(controller, animated: true)
    }

    func pushInvestmentSummary(_ manager: SDUILoader) {
        let controller = CDBInvestmentSummaryFactory().makeBuilder(router: self, manager: manager)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension CDBCoodinator: SDUICoodinatorRouter {
    
    public func onNext(_ current: UIViewController, type: ActionButtonType, value: String) {
        switch current {
        case current as CDBListView where type == .deeplink: pushDetail()
        case current as CDBDetailView where type == .deeplink: pushIinvestmentValue()
        default: break
        }
    }
    
    public func onNext(_ current: UIViewController, manager: SDUILoader) {
        switch current {
        case current as CDBInvestmentValueView: pushInvestmentSummary(manager)
        default: break
        }
    }
    
}
