//
//  FullButtomDTO.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import Foundation

public struct FullButtomDTO: Codable {
    public let title: String
    public let theme: String?
    public let action: ActionButtom
    
    public init(title: String, theme: String? = nil, action: ActionButtom) {
        self.title = title
        self.theme = theme
        self.action = action
    }
}
