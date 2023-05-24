//
//  NetworkClient.swift
//  NetworkService
//
//  Created by Julio Junior on 23/02/23.
//

import Foundation

public protocol ApiEndpointExposable {
    var path: String { get }
}

public protocol NetworkClient {
    func execute(_ endpoint: ApiEndpointExposable, completion: @escaping ((Result<Data, Error>) -> Void))
}
