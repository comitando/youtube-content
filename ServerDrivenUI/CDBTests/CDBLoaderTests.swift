//
//  CDBLoaderTests.swift
//  CDBTests
//
//  Created by Julio Junior on 23/02/23.
//

import XCTest
import SDUI
@testable import CDB

//final class CDBLoaderTests: XCTestCase {
//
//    func test_initializer() {
//        let (_, network, observability)  = makeSUT()
//        XCTAssertEqual(network.executeCount, 0)
//        XCTAssertEqual(observability.sendDataCount, 0)
//    }
//    
//    func test_request_returned_SDUI() {
//        let (sut, network, _)  = makeSUT()
//        
//        var returnedResult: SDUIDTO?
//        sut.request { dto in
//            returnedResult = dto
//        }
//        
//        let (response, model) = mockSDUI()
//        network.completion(.success(response))
//        
//        XCTAssertEqual(returnedResult?.title, model.title)
//        XCTAssertEqual(returnedResult?.screenViewAnalytics, model.screenViewAnalytics)
//        XCTAssertEqual(returnedResult?.body.count, model.body.count)
//    }
//    
//    func test_request_returned_error() {
//        let (sut, network, observability)  = makeSUT()
//        
//        var returnedResult: SDUIDTO?
//        sut.request { dto in
//            returnedResult = dto
//        }
//        
//        let error = NSError(domain: "any error", code: -1)
//        network.completion(.failure(error))
//        
//        XCTAssertEqual(returnedResult?.title, "Error")
//        XCTAssertEqual(observability.sendDataCount, 1)
//    }
//    
//    func test_request_returned_error_by_mapper() {
//        let (sut, network, observability)  = makeSUT()
//        
//        var returnedResult: SDUIDTO?
//        sut.request { dto in
//            returnedResult = dto
//        }
//        
//        let response = Data("1".utf8)
//        network.completion(.success(response))
//        
//        XCTAssertEqual(returnedResult?.title, "Error")
//        XCTAssertEqual(observability.sendDataCount, 1)
//    }
//    
//    func test_dealloc_loader() {
//        let network = NetworkClientSpy()
//        let observability = ObservabilitySpy()
//        var sut: CDBUILoader? = CDBUILoader(network: network, observability: observability)
//        
//        var returnedResult: SDUIDTO?
//        sut?.request { dto in
//            returnedResult = dto
//        }
//        
//        sut = nil
//        let response = Data("0".utf8)
//        network.completion(.success(response))
//        
//        XCTAssertNil(returnedResult)
//    }
//    
//    func makeSUT() -> (loader: CDBUILoader, network: NetworkClientSpy, observability: ObservabilitySpy) {
//        SDUIBuilder.initialize()
//        let network = NetworkClientSpy()
//        let observability = ObservabilitySpy()
//        
//        let sut = CDBUILoader(network: network, observability: observability)
//        return (sut, network, observability)
//    }
//    
//}
