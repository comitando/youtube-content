//
//  DTOBuilder.swift
//  SDUI
//
//  Created by JOAO PEREIRA on 24/05/23.
//

import Foundation

@resultBuilder
public enum SDUIDTOBuilder {
    public static func buildEither(first builders: [SDUIBuilderProtocol]) -> [SDUIDynamic] {
        builders.flatMap { $0.body }
    }

    public static func buildEither(second builders: [SDUIBuilderProtocol]) -> [SDUIDynamic] {
        builders.flatMap { $0.body }
    }

    public static func buildOptional(_ builders: [SDUIBuilderProtocol]?) -> [SDUIDynamic] {
        guard let builders = builders else { return [] }

        return builders.flatMap { $0.body }
    }

    public static func buildExpression(_ builder: SDUIBuilderProtocol) -> [SDUIDynamic] {
        builder.body
    }

    public static func buildExpression(_ builder: [SDUIBuilderProtocol]) -> [SDUIDynamic] {
        builder.flatMap {
            $0.body
        }
    }

    public static func buildExpression(_ builder: [SDUIDynamic]) -> [SDUIDynamic] {
        builder
    }

    public static func buildArray(_ components: [[SDUIDynamic]]) -> [SDUIDynamic] {
        components.flatMap {
            $0
        }
    }

    public static func buildExpression(_ builder: SDUIBuilderProtocol?) -> [SDUIDynamic] {
        guard let builder = builder else { return [] }

        return builder.body
    }

    public static func buildBlock(_ components: [SDUIDynamic]...) -> [SDUIDynamic] {
        components.flatMap { $0 }
    }
}

public class DTOBuilder {
    public let dtos: [SDUIDynamic]

    public init() {
        self.dtos = []
    }

    public init(dtos: [SDUIDynamic]) {
        self.dtos = dtos
    }

    public init(@SDUIDTOBuilder _ dtos: () -> [SDUIDynamic]) {
        self.dtos = dtos()
    }

    public static func build(@SDUIDTOBuilder _ dtos: () -> [SDUIDynamic]) -> DTOBuilder {
        .init(dtos: dtos())
    }
}
