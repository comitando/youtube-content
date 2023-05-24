//
//  Heading5DTO.swift
//  SDUI
//
//  Created by Julio Junior on 24/02/23.
//

import Foundation

public struct HeadingDTO: Codable {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}
