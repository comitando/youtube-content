import Foundation
import SDUI

protocol SDUIFailureDataSource {
    static func toSDUIDTO() -> SDUIDTO
}

final class CDBFailureData: SDUIFailureDataSource {
    
    static func toSDUIDTO() -> SDUIDTO  {
        return SDUIDTO(
            title: "Error",
            screenViewAnalytics: "error_view",
            body: [
                SDUIDynamic(id: "key")
            ]
        )
    }
    
}
