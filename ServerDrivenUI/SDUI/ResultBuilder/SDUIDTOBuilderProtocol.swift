//
//  SDUIDTOBuilderProtocol.swift
//  SDUI
//
//  Created by JOAO PEREIRA on 24/05/23.
//

import Foundation

public protocol SDUIDTOBuilderProtocol: SDUIBuilderProtocol {
    associatedtype TargetDTO: SDUIBuildableProtocol
    static var id: String { get }
    var dto: TargetDTO? { get set }
}

public extension SDUIDTOBuilderProtocol {
    var body: [SDUIDynamic] {
        get {
            guard let dto = dto else { return [SDUIDynamic]() }
            return [SDUIDynamic(id: Self.id, content: dto)]
        }
        set(inputComponents) {
            if inputComponents.isEmpty { dto = nil }
            guard inputComponents.count == 1,
                  let newDTO = inputComponents.first?.content as? TargetDTO else { return }
            dto = newDTO
        }
    }
}
