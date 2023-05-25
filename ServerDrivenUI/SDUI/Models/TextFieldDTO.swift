import Foundation

public final class TextFieldBuilder: SDUIDTOBuilderProtocol {
    public static var id: String { "MoneyTextField" }

    public var dto: TextFieldDTO?

    public init(
        title: String,
        placeHolder: String? = nil,
        message: String? = nil,
        buttons: [QuickButton]
    ) {
        dto = TextFieldDTO(
            title: title,
            placeHolder: placeHolder,
            message: message,
            buttons: buttons
        )
    }
}

extension TextFieldDTO: SDUIBuildableProtocol {
    public typealias Builder = TextFieldBuilder
}

public struct TextFieldDTO: Codable {
    public let title: String
    public let placeHolder: String?
    public let message: String?
    public let buttons: [QuickButton]
    
    public init(
        title: String,
        placeHolder: String? = nil,
        message: String? = nil,
        buttons: [QuickButton]
    ) {
        self.title = title
        self.placeHolder = placeHolder
        self.message = message
        self.buttons = buttons
    }
}
