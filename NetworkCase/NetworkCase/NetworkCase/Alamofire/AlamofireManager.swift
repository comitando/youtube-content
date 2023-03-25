import Alamofire
import Foundation

final class AlamofireManager: NetworkClient {
    
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.ephemeral
        return Session(configuration: configuration)
    }()

    
    private struct URLSessionTaskWrapper: NetworkClientTask {
        let wrapped: URLSessionTask
        func cancel() {
            wrapped.cancel()
        }
    }
    
    func request(from url: URL, completion: @escaping (NetworkClientResult) -> Void) -> NetworkClientTask? {
        let request = sessionManager.request(url)
        request.responseData { data in
            switch data.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(.failure(error))
            }
        }
        return nil
    }
    
}
