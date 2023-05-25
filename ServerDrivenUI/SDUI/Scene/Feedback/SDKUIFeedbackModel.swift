//
//  SDKUIFeedbackModel.swift
//  SDUI
//
//  Created by Julio Junior on 02/03/23.
//

import Foundation

public struct FeedbackSystem {
    let icon: String?
    let title: String
    let subtitle: String
    let buttonTitle: String
    
    public init(icon: String? = nil, title: String, subtitle: String, buttonTitle: String) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
    }
}

enum SDKUIFeedbackModel {
    
    enum Request {
        case fetchData
    }
    
    enum Response {
        case dataView(FeedbackSystem)
    }
    
    enum ViewModel {
        case showData(FeedbackSystem)
    }
}
