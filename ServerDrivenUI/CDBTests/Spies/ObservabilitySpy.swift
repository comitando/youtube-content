//
//  ObservabilitySpy.swift
//  Poc
//
//  Created by Julio Junior on 24/02/23.
//

import Foundation
import Observability

final class ObservabilitySpy: Observability {
    
    private(set) var sendDataCount = 0
    func sendData(_ error: Error) {
        sendDataCount += 1
    }
    
}
