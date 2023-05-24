//
//  SDUIFeedbackInteractor.swift
//  SDUI
//
//  Created by Julio Junior on 02/03/23.
//

import Foundation

protocol SDUIFeedbackBusinessLogic {
    func doRequest(_ request: SDKUIFeedbackModel.Request)
}

final class SDUIFeedbackInteractor {
    
    private let dataSource: FeedbackSystem
    private let presenter: SDUIFeedbackPresentationLogic
    
    init(dataSource: FeedbackSystem, presenter: SDUIFeedbackPresentationLogic) {
        self.dataSource = dataSource
        self.presenter = presenter
    }
    
    private func fetchDataView() {
        presenter.presentResponse(.dataView(dataSource))
    }
    
}

extension SDUIFeedbackInteractor: SDUIFeedbackBusinessLogic {
    func doRequest(_ request: SDKUIFeedbackModel.Request) {
        switch request {
        case .fetchData: fetchDataView()
        }
    }
}
