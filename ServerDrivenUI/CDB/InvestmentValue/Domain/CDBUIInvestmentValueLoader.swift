import Foundation
import NetworkService
import SDUI

struct CDBInvestmentEndpoint: ApiEndpointExposable {
    var path: String
    init(path: String = "investment/cdb/investment") {
        self.path = path
    }
}

final class CDBUIInvestmentValueLoader: SDUILoader {
    
    private let endpoint: ApiEndpointExposable
    private let network: NetworkClient
    
    init(
        endpoint: ApiEndpointExposable = CDBDetailEndpoint(),
        network: NetworkClient
    ) {
        self.endpoint = endpoint
        self.network = network
    }
    
    public func request(_ completion: @escaping ((SDUIDTO) -> Void)) {
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
