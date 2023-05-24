//
//  CDBUseCaseTests.swift
//  CDBTests
//
//  Created by Julio Junior on 23/02/23.
//

import XCTest
import Observability
import NetworkService
import SDUI
@testable import CDB

//final class CDBUseCaseTests: XCTestCase {
//
//    func test_initializer() {
//        let (_, network, observability)  = makeSUT()
//        XCTAssertEqual(network.executeCount, 0)
//        XCTAssertEqual(observability.sendDataCount, 0)
//    }
//    
//    func test_doRequest_returned_sucess() {
//        let (sut, network, _)  = makeSUT()
//        
//        sut.doRequest()
//        network.completion(.success(Data()))
//        
//        XCTAssertEqual(network.executeCount, 1)
//        XCTAssertNotNil(sut.cdbRules)
//    }
//    
//    func test_doRequest_returned_error() {
//        let (sut, network, observability)  = makeSUT()
//        
//        sut.doRequest()
//        let error = NSError(domain: "any error", code: -1)
//        network.completion(.failure(error))
//        
//        XCTAssertEqual(observability.sendDataCount, 1)
//        XCTAssertNil(sut.cdbRules)
//    }
//    
//    func test_dealloc_useCase() {
//        let network = NetworkClientSpy()
//        let observability = ObservabilitySpy()
//        var sut: CDBUseCase? = CDBUseCase(network: network, observability: observability)
//        
//        sut?.doRequest()
//        
//        sut = nil
//        network.completion(.success(Data()))
//        
//        XCTAssertNil(sut?.cdbRules)
//    }
//    
//    func test_eventHanlder_newValue() {
//        let (sut, network, _)  = makeSUT()
//        
//        sut.doRequest()
//        network.completion(.success(Data()))
//        
//        sut.eventHandler(.newDataValue("10"))
//        XCTAssertEqual(sut.cdbRules?.postContent.value, 10)
//    }
//    
//    func test_eventHanlder_addValue() {
//        let (sut, network, _)  = makeSUT()
//        sut.doRequest()
//        network.completion(.success(Data()))
//        
//        sut.eventHandler(.addValue("5"))
//        XCTAssertEqual(sut.cdbRules?.postContent.value, 5)
//        
//        sut.eventHandler(.addValue("5"))
//        XCTAssertEqual(sut.cdbRules?.postContent.value, 10)
//    }
//    
//    func test_validateRules_returned_emptyValue() {
//        let (sut, network, _)  = makeSUT()
//        sut.doRequest()
//        network.completion(.success(Data()))
//        
//        var returnedResult: SDUIEventsError?
//        sut.validateRules { error in
//            returnedResult = error
//        }
//        
//        XCTAssertEqual(returnedResult?.message(), CDBError.emptyValue.message())
//    }
//    
//    func test_validateRules_returned_minValue() {
//        let (sut, network, _)  = makeSUT()
//        sut.doRequest()
//        network.completion(.success(Data()))
//        
//        sut.eventHandler(.newDataValue("10"))
//        
//        var returnedResult: SDUIEventsError?
//        sut.validateRules { error in
//            returnedResult = error
//        }
//        
//        XCTAssertEqual(returnedResult?.message(), CDBError.minValue(100).message())
//    }
//    
//    func test_validateRules_returned_maxValue() {
//        let (sut, network, _)  = makeSUT()
//        sut.doRequest()
//        network.completion(.success(Data()))
//        
//        sut.eventHandler(.newDataValue("100000"))
//        
//        var returnedResult: SDUIEventsError?
//        sut.validateRules { error in
//            returnedResult = error
//        }
//        
//        XCTAssertEqual(returnedResult?.message(), CDBError.maxValue(10000).message())
//    }
//    
//    func test_validateRules_returned_success() {
//        let (sut, network, _)  = makeSUT()
//        sut.doRequest()
//        network.completion(.success(Data()))
//        
//        sut.eventHandler(.newDataValue("1000"))
//        
//        var returnedResult: SDUIEventsError?
//        sut.validateRules { error in
//            returnedResult = error
//        }
//        
//        XCTAssertNil(returnedResult)
//    }
//    
//    func test_validateRules_dont_work_when_rules_is_empty() {
//        let (sut, _, _)  = makeSUT()
//        
//        sut.eventHandler(.newDataValue("1000"))
//        
//        var returnedResult: SDUIEventsError?
//        sut.validateRules { error in
//            returnedResult = error
//        }
//        
//        XCTAssertNil(returnedResult)
//    }
//    
//    func makeSUT() -> (loader: CDBUseCase, network: NetworkClientSpy, observability: ObservabilitySpy) {
//        let network = NetworkClientSpy()
//        let observability = ObservabilitySpy()
//        let sut = CDBUseCase(network: network, observability: observability)
//        return (sut, network, observability)
//    }
//    
//}
