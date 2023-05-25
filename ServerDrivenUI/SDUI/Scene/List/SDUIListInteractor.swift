import Foundation

public protocol SDUIBusinessLogic {
    func doRequest(_ request: SDKUIListModel.Request)
}

public final class SDUIListInteractor {
    
    private let service: SDUILoader
    private let presenter: SDUIPresentationLogic
    
    public init(service: SDUILoader, presenter: SDUIPresentationLogic) {
        self.service = service
        self.presenter = presenter
    }
    
    private func fetchDataView() {
        presenter.presentResponse(.isLoading(true))
        service.request { [weak self] viewModel in
            guard let self else { return }
            self.presenter.presentResponse(.isLoading(false))
            self.presenter.presentResponse(.dataView(viewModel))
        }
    }
    
    private func postDataView() {
        service.sendEventData(.postData) { [weak self] error in
            self?.presenter.presentResponse(.successfullyPost(error))
        }
    }
    
    private func sendDataEvent(_ event: SDUIEvents) {
        service.sendEventData(event) { _ in
            
        }
    }
    
    private func sendManager() {
        presenter.presentResponse(.transitionManager(service))
    }
}

extension SDUIListInteractor: SDUIBusinessLogic {
    public func doRequest(_ request: SDKUIListModel.Request) {
        switch request {
        case .fetchData: fetchDataView()
        case .postData: postDataView()
        case .transitionManager: sendManager()
        case let .updateData(event): sendDataEvent(event)
        }
    }
}
