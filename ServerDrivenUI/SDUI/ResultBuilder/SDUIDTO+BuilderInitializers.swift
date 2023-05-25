//
//  SDUIDTO+BuilderInitializers.swift
//  SDUI
//
//  Created by JOAO PEREIRA on 24/05/23.
//

import Foundation


extension SDUIDTO {
    public init(
        title: String,
        isRefreshEnabled: Bool = true,
        screenViewAnalytics: String,
        body: DTOBuilder = .init(),
        footer: DTOBuilder = .init()
    ) {
        self.title = title
        self.isRefreshEnabled = isRefreshEnabled
        self.screenViewAnalytics = screenViewAnalytics
        self.body = body.dtos
        self.footer = footer.dtos
    }

    public init(
        title: String,
        isRefreshEnabled: Bool = true,
        screenViewAnalytics: String,
        @SDUIDTOBuilder body: () -> [SDUIDynamic],
        @SDUIDTOBuilder footer: () -> [SDUIDynamic]
    ) {
        self.title = title
        self.isRefreshEnabled = isRefreshEnabled
        self.screenViewAnalytics = screenViewAnalytics
        self.body = body()
        self.footer = footer()
    }

    public init(
        title: String,
        isRefreshEnabled: Bool = true,
        screenViewAnalytics: String,
        @SDUIDTOBuilder body: () -> [SDUIDynamic]
    ) {
        self.title = title
        self.isRefreshEnabled = isRefreshEnabled
        self.screenViewAnalytics = screenViewAnalytics
        self.body = body()
        self.footer = nil
    }
}
