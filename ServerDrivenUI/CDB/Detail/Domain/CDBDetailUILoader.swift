import Foundation
import NetworkService
import SDUI

struct CDBDetailEndpoint: ApiEndpointExposable {
    var path: String
    init(path: String = "investment/cdb/server-driven-ui") {
        self.path = path
    }
}

final class CDBDetailUILoader: SDUILoader {
    
    private let endpoint: ApiEndpointExposable
    private let network: NetworkClient
    
    init(endpoint: ApiEndpointExposable = CDBDetailEndpoint(), network: NetworkClient) {
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
