import Foundation

public struct SDUIDTO: Codable {
    public let title: String
    public let isRefreshEnabled: Bool
    public let screenViewAnalytics: String
    public let body: [SDUIDynamic]
    public let footer: [SDUIDynamic]?
    
    public init(
        title: String,
        isRefreshEnabled: Bool = true,
        screenViewAnalytics: String,
        body: [SDUIDynamic],
        footer: [SDUIDynamic]? = nil
    ) {
        self.title = title
        self.isRefreshEnabled = isRefreshEnabled
        self.screenViewAnalytics = screenViewAnalytics
        self.body = body
        self.footer = footer
    }
}

public final class SDUIDynamic: Codable {
    public let id: String
    private(set) var content: Any?
    
    public init(id: String, content: Any? = nil) {
        self.id = id
        self.content = content
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case content
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        var auxContent: Any?
        if container.contains(.content), let decode = SDUIDynamic.decoders[id] {
            auxContent = try? decode(container)
        }
        
        content = auxContent
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        
        if let content = self.content {
            guard let encode = SDUIDynamic.encoders[id] else {
                let context = EncodingError.Context(codingPath: [], debugDescription: "Invalid attachment: \(id).")
                throw EncodingError.invalidValue(self, context)
            }
            
            try encode(content, &container)
        } else {
            try container.encodeNil(forKey: .content)
        }
    }
    
    private typealias DynamicDTOType = String
    private typealias DynamicDTODecoder = (KeyedDecodingContainer<CodingKeys>) throws -> Any
    private typealias DynamicDTOEncoder = (Any, inout KeyedEncodingContainer<CodingKeys>) throws -> Void

    private static var types: [String: DynamicDTOType] = [:]
    private static var decoders: [String: DynamicDTODecoder] = [:]
    private static var encoders: [String: DynamicDTOEncoder] = [:]
    
    public static func register<T: Codable>(_ type: T.Type, for typeName: String) {
        types[typeName] = String(describing: type)
        
        decoders[typeName] = { container in
            try container.decode(T.self, forKey: .content)
        }
        
        encoders[typeName] = { payload, container in
            try container.encode(payload as! T, forKey: .content)
        }
    }
    
    public static func dynamicDTO<T: Codable>(registeredDTO content: T) -> SDUIDynamic? {
        guard let identifier = types.first(where: { $0.value == .init(describing: T.self) })?.key else {
            return nil
        }
        
        return .init(id: identifier, content: content)
    }
    
    public func get<T>(_ type: T.Type) -> T? {
        self.content as? T
    }
    
}
