//
//  SDUIBuilder.swift
//  SDUI
//
//  Created by Julio Junior on 02/03/23.
//

import Foundation

public final class SDUIBuilder {
    public static func initialize() {
        SDUIDynamic.register(HeadingDTO.self, for: "Heading")
        SDUIDynamic.register(QuickActionsDTO.self, for: "QuickActions")
        SDUIDynamic.register(InvestimentCardDTO.self, for: "InvestimentCard")
        SDUIDynamic.register(FullButtonDTO.self, for: "FullButton")
        SDUIDynamic.register(TextFieldDTO.self, for: "MoneyTextField")
    }
}
