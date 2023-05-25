import SDUI
import NetworkService

struct CDBDomainEndpoint: ApiEndpointExposable {
    var path: String = "investment/cdb/rules"
}

final class CDBManager {
    
    private(set) var cdbRules: CDBDTO?
    private let network: NetworkClient
    private let endpoint: ApiEndpointExposable

    init(
        cdbRules: CDBDTO? = nil,
        network: NetworkClient,
        endpoint: ApiEndpointExposable = CDBDomainEndpoint()
    ) {
        self.cdbRules = cdbRules
        self.network = network
        self.endpoint = endpoint
        doRequest()
    }
    
    private func doRequest() {
        network.execute(endpoint) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success: self.cdbRules = CDBDTO(postContent: CDBPost())
            default: break
            }
        }
    }
    
    private func newDataValue(_ value: String) {
        let newValue = DecimalFormatter.shared.decimalStringToDecimalNumberFormatter(value)
        cdbRules?.postContent.value = newValue?.doubleValue ?? 0
        print(cdbRules?.postContent.value ?? "0")
    }
    
    func sendRequest(completion: @escaping ((Error?) -> Void)) {
        network.execute(endpoint) { result in
            switch result {
            case .success: completion(nil)
            case let .failure(error): completion(error)
            }
        }
    }
}

extension CDBManager: SDUILoader {
    func sendEventData(_ event: SDUIEvents, completion: @escaping ((Error?) -> Void)) {
        switch event {
        case let .newDataValue(value): newDataValue(value)
        case .postData: sendRequest(completion: completion)
        }
    }
}
