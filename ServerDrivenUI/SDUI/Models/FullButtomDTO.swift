//
//  FullButtonDTO.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import Foundation

public final class FullButtonBuilder: SDUIDTOBuilderProtocol {
    public static var id: String { "FullButton" }

    public var dto: FullButtonDTO?

    public init(title: String, theme: String? = nil, action: ActionButton) {
        dto = FullButtonDTO(title: title, theme: theme, action: action)
    }
}

extension FullButtonDTO: SDUIBuildableProtocol {
    public typealias Builder = FullButtonBuilder
}

public struct FullButtonDTO: Codable {
    public let title: String
    public let theme: String?
    public let action: ActionButton
    
    public init(title: String, theme: String? = nil, action: ActionButton) {
        self.title = title
        self.theme = theme
        self.action = action
    }
}
