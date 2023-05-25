import Foundation

public final class QuickActionsBuilder: SDUIDTOBuilderProtocol {
    public static var id: String { "QuickActions" }

    public var dto: QuickActionsDTO?

    public init(items: [QuickButton]) {
        dto = QuickActionsDTO(items: items)
    }
}

extension QuickActionsDTO: SDUIBuildableProtocol {
    public typealias Builder = QuickActionsBuilder
}

public struct QuickActionsDTO: Codable {
    public let items: [QuickButton]
    
    public init(items: [QuickButton]) {
        self.items = items
    }
}

public struct QuickButton: Codable {
    public let title: String
    public let action: ActionButton
    
    public init(title: String, action: ActionButton) {
        self.title = title
        self.action = action
    }
}

public struct ActionButton: Codable {
    public let type: ActionButtonType
    public let value: String
    
    public init(type: ActionButtonType, value: String) {
        self.type = type
        self.value = value
    }
}

public enum ActionButtonType: String, Codable {
    
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
        self = ActionButtonType(rawValue: value) ?? .systemError
    }
}

