import Foundation
import NetworkService
import SDUI

struct CDBInvestmentSummaryEndpoint: ApiEndpointExposable {
    var path: String
    init(path: String = "investment/cdb/investment-summary") {
        self.path = path
    }
}

final class CDBUIInvestmentSummaryLoader: SDUILoader {
    
    private let endpoint: ApiEndpointExposable
    private let network: NetworkClient
    
    init(endpoint: ApiEndpointExposable = CDBInvestmentSummaryEndpoint(), network: NetworkClient) {
        self.endpoint = endpoint
        self.network = network
    }
    
    func request(_ completion: @escaping ((SDUIDTO) -> Void)) {
        network.execute(endpoint) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data) where self.validateToSDUI(data):
                completion(self.adapteeToSDUI(data))
            default:
                completion(CDBFailureData.toSDUIDTO())
            }
        }
    }
}
