import Foundation

final class URLSessionManager: NetworkClient {
    
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
    
    private struct URLSessionTaskWrapper: NetworkClientTask {
        let wrapped: URLSessionTask
        func cancel() {
            wrapped.cancel()
        }
    }
    
    func request(from url: URL, task: ((NetworkClientTask) -> Void)?, completion: @escaping (NetworkClientResult) -> Void) {
        let dataTask = session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "unexpected values", code: -1)))
            }
        }
        dataTask.resume()
        task?(URLSessionTaskWrapper(wrapped: dataTask))
    }
    
}

