//
//  NetworkClientSpy.swift
//  Poc
//
//  Created by Julio Junior on 24/02/23.
//

import Foundation
import NetworkService

final class NetworkClientSpy: NetworkClient {
    
    private(set) var executeCount = 0
    private var completionHandler: ((Result<Data, Error>) -> Void)?
    func execute(_ endpoint: ApiEndpointExposable, completion: @escaping ((Result<Data, Error>) -> Void)) {
        executeCount += 1
        completionHandler = completion
    }
    
    func completion(_ result: Result<Data, Error>) {
        completionHandler?(result)
    }
    
}
