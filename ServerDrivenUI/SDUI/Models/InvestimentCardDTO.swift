import Foundation

public final class InvestimentCardBuilder: SDUIDTOBuilderProtocol {
    public static var id: String { "InvestimentCard" }

    public var dto: InvestimentCardDTO?

    public init(title: String, subtitle: String, tag: String, infos: [InvestimentCardInfo], action: QuickButton) {
        dto = InvestimentCardDTO(title: title, subtitle: subtitle, tag: tag, infos: infos, action: action)
    }
}

extension InvestimentCardDTO: SDUIBuildableProtocol {
    public typealias Builder = QuickActionsBuilder
}

public struct InvestimentCardDTO: Codable {
    public let title: String
    public let subtitle: String
    public let tag: String
    public let infos: [InvestimentCardInfo]
    public let action: QuickButton?
    
    public init(title: String, subtitle: String, tag: String, infos: [InvestimentCardInfo], action: QuickButton) {
        self.title = title
        self.subtitle = subtitle
        self.tag = tag
        self.infos = infos
        self.action = action
    }
}

public struct InvestimentCardInfo: Codable {
    public let title: String
    public let subtitle: String
    
    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
