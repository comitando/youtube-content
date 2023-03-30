import XCTest
import Alamofire
@testable import NetworkCase

final class AlamofireManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        MockURLProtocol.startInterceptingRequests()
    }
    
    override func tearDown() {
        super.tearDown()
        MockURLProtocol.stopInterceptingRequests()
    }
    
    func test_request_with_error() {
        let error = NSError(domain: "any error for alamofire", code: 1)
        let result = assert(data: nil, error: error)
        
        switch result {
        case let .failure(receivedError as NSError):
            XCTAssertTrue(receivedError.localizedDescription.contains(error.localizedDescription))
            // Alamofire internamente altera o objeto de error por isso não é possível fazer uma comparação direto e sim um contains
        default:
            XCTFail("Espero falha, porem retornou \(String(describing: result))")
        }
    }
    
    func test_request_with_success() {
        let string = "response"
        let result = assert(data: string.data(using: .utf8), error: nil)
        
        switch result {
        case let .success(data):
            XCTAssertEqual(String(data: data, encoding: .utf8), string)
        default:
            XCTFail("Espero sucesso, porem retornou \(String(describing: result))")
        }
    }
    
    private func assert(data: Data?, error: Error?, file: StaticString = #file, line: UInt = #line) -> NetworkClient.NetworkClientResult? {
        let url = URL(string: "https://comitando.com.br")!
        let sut = makeSUT(file: file, line: line)
        MockURLProtocol.stub(data: data, error: error)
        
        let exp = expectation(description: "aguardando retorno da clousure")
        var receivedResult: NetworkClient.NetworkClientResult?
        sut.request(from: url, task: nil) { result in
            receivedResult = result
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return receivedResult
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> AlamofireManager {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireManager(sessionManager: session)
        trackForMemoryLeaks(sut)
        return sut
    }
    
    private func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "A instância deveria ter sido desalocada, possível vazamento de memória.", file: file, line: line)
        }
    }
}
