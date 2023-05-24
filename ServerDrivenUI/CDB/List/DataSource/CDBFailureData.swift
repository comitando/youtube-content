//
//  CDBFailureData.swift
//  Poc
//
//  Created by Julio Junior on 23/02/23.
//

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
