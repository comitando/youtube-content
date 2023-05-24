//
//  CDBUseCase.swift
//  Poc
//
//  Created by Julio Junior on 23/02/23.
//

import SDUI
import Observability
import NetworkService

struct CDBDomainEndpoint: ApiEndpointExposable {
    var path: String = "investment/cdb/rules"
}

final class CDBManager {
    
    private(set) var cdbRules: CDBDTO?
    private let network: NetworkClient
    private let observability: Observability
    private let endpoint: ApiEndpointExposable

    init(
        cdbRules: CDBDTO? = nil,
        network: NetworkClient,
        observability: Observability,
        endpoint: ApiEndpointExposable = CDBDomainEndpoint()
    ) {
        self.cdbRules = cdbRules
        self.network = network
        self.observability = observability
        self.endpoint = endpoint
        doRequest()
    }
    
    private func doRequest() {
        network.execute(endpoint) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success: self.cdbRules = CDBDTO(postContent: CDBPost())
            case let .failure(error):
                self.observability.sendData(error)
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
//
//    func eventHandler(_ handler: SDUIEvents) {
//        switch handler {
//        case let .newDataValue(value): newDataValue(value)
//        }
//    }
//
//    func validateRules(completion: @escaping ((SDUIEventsError?) -> Void)) {
//        guard let cdbRules else { return }
//
//        let currentValue = cdbRules.postContent.value
//        var returnedValue: CDBError? = nil
//
//        if currentValue == 0 {
//            returnedValue = .emptyValue
//        } else if currentValue < cdbRules.minValue {
//            returnedValue = .minValue(cdbRules.minValue)
//        } else if currentValue > cdbRules.maxValue {
//            returnedValue = .maxValue(cdbRules.maxValue)
//        }
//
//        completion(returnedValue)
//    }
//
//
}

extension CDBManager: SDUILoader {
    func sendEventData(_ event: SDUIEvents, completion: @escaping ((Error?) -> Void)) {
        switch event {
        case let .newDataValue(value): newDataValue(value)
        case .postData: sendRequest(completion: completion)
        }
    }
}
