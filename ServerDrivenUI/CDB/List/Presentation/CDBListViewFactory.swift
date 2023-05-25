import UIKit
import SDUI
import Coordinator
import NetworkService

final class CDBListViewFactory {
    
    func makeBuilder(router: SDUICoodinatorRouter) -> UIViewController {
        let service = CDBUILocalLoader()
        let presenter = SDUIListPresenter()
        let interactor = SDUIListInteractor(service: service, presenter: presenter)
        let controller = CDBListView(interactor: interactor, router: router)
        presenter.controller = controller
        
        return controller
    }
    
}

final class CDBListView: SDUIListController {}
