//
//  QuickActions.swift
//  SDUI
//
//  Created by Julio Junior on 24/02/23.
//

import Foundation

public struct QuickActionsDTO: Codable {
    public let items: [QuickButtom]
    
    public init(items: [QuickButtom]) {
        self.items = items
    }
}

public struct QuickButtom: Codable {
    public let title: String
    public let action: ActionButtom
    
    public init(title: String, action: ActionButtom) {
        self.title = title
        self.action = action
    }
}

public struct ActionButtom: Codable {
    public let type: ActionButtomType
    public let value: String
    
    public init(type: ActionButtomType, value: String) {
        self.type = type
        self.value = value
    }
}

public enum ActionButtomType: String, Codable {
    
    // navegação
    case reload
    case deeplink
    case transition
    
    // estado
    case addValue
    case newValue
    case sendEvents
    
    // custom error
    case systemError
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        self = ActionButtomType(rawValue: value) ?? .systemError
    }
}

