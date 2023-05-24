//
//  CDBInvestmentUILoader.swift
//  CDB
//
//  Created by Julio Junior on 01/03/23.
//

import Foundation
import NetworkService
import Observability
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
    private let observability: Observability
    
    init(
        endpoint: ApiEndpointExposable = CDBDetailEndpoint(),
        network: NetworkClient,
        observability: Observability
    ) {
        self.endpoint = endpoint
        self.network = network
        self.observability = observability
    }
    
    public func request(_ completion: @escaping ((SDUIDTO) -> Void)) {
        network.execute(endpoint) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data) where self.validateToSDUI(data):
                completion(self.adapteeToSDUI(data))
            case let .failure(error):
                self.observability.sendData(error)
                completion(CDBFailureData.toSDUIDTO())
            default:
                let customError = NSError(domain: "não foi possivel fazer o parser", code: -1)
                self.observability.sendData(customError)
                completion(CDBFailureData.toSDUIDTO())
            }
        }
    }
}
