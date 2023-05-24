//
//  InvestimentCardDTO.swift
//  SDUI
//
//  Created by Julio Junior on 24/02/23.
//

import Foundation

public struct InvestimentCardDTO: Codable {
    public let title: String
    public let subtitle: String
    public let tag: String
    public let infos: [InvestimentCardInfo]
    public let action: QuickButtom?
    
    public init(title: String, subtitle: String, tag: String, infos: [InvestimentCardInfo], action: QuickButtom) {
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
