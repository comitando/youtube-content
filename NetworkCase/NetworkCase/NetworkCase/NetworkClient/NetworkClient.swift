import Foundation

protocol NetworkClientTask {
    func cancel()
}

protocol NetworkClient {
    typealias NetworkClientResult = Result<Data, Error>
    
    /// Ação de carregar dados de uma API
    /// - Parameters:
    ///   - url: url path
    ///   - completion: O bloco `completion` pode ser executado em qualquer thread, quem consumir precisa tratar
    @discardableResult func request(from url: URL, completion: @escaping (NetworkClientResult) -> Void) -> NetworkClientTask?
}
