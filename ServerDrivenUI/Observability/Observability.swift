//
//  Observability.swift
//  Observability
//
//  Created by Julio Junior on 23/02/23.
//

import Foundation

public protocol Observability {
    func sendData(_ error: Error)
}
