//
//  TextFieldDTO.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import Foundation

public struct TextFieldDTO: Codable {
    public let title: String
    public let placeHolder: String?
    public let message: String?
    public let buttoms: [QuickButtom]
    
    public init(
        title: String,
        placeHolder: String? = nil,
        message: String? = nil,
        buttoms: [QuickButtom]
    ) {
        self.title = title
        self.placeHolder = placeHolder
        self.message = message
        self.buttoms = buttoms
    }
}
