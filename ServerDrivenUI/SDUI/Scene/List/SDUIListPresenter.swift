import Foundation

public protocol SDUIPresentationLogic {
    func presentResponse(_ response: SDKUIListModel.Response)
}

public final class SDUIListPresenter {
    
    public weak var controller: SDUIDisplayLogic?
    
    public init() {}
    
    private func onLoadingChange(_ isLoading: Bool) {
        controller?.displayViewModel(.isLoading(isLoading))
    }
    
    private func dataView(_ viewModel: SDUIDTO) {
        controller?.displayViewModel(.showData(viewModel))
    }
    
    private func sendManager(_ manager: SDUILoader) {
        controller?.displayViewModel(.sendManager(manager))
    }
    
    private func successfullyPost(_ error: Error?) {
        controller?.displayViewModel(.finished(error))
    }
}

extension SDUIListPresenter: SDUIPresentationLogic {
    public func presentResponse(_ response: SDKUIListModel.Response) {
        switch response {
        case let .isLoading(isLoading): onLoadingChange(isLoading)
        case let .dataView(viewModel): dataView(viewModel)
        case let .transitionManager(manager): sendManager(manager)
        case let .successfullyPost(error): successfullyPost(error)
        }
    }
}
