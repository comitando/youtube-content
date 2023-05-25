import Foundation

public protocol ApiEndpointExposable {
    var path: String { get }
}

public protocol NetworkClient {
    func execute(_ endpoint: ApiEndpointExposable, completion: @escaping ((Result<Data, Error>) -> Void))
}
