//
//  Heading5DTO.swift
//  SDUI
//
//  Created by Julio Junior on 24/02/23.
//

import Foundation

public final class HeadingBuilder: SDUIDTOBuilderProtocol {
    public static var id: String { "Heading" }

    public var dto: HeadingDTO?

    public init(
        _ title: String
    ) {
        dto = HeadingDTO(title: title)
    }
}

extension HeadingDTO: SDUIBuildableProtocol {
    public typealias Builder = HeadingBuilder
}

public struct HeadingDTO: Codable {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}
