//
//  SDUIFeedbackPresenter.swift
//  SDUI
//
//  Created by Julio Junior on 02/03/23.
//

import Foundation

protocol SDUIFeedbackPresentationLogic {
    func presentResponse(_ response: SDKUIFeedbackModel.Response)
}

final class SDUIFeedbackPresenter {
    weak var controller: SDUIFeedbackDisplayLogic?
    init() {}
}

extension SDUIFeedbackPresenter: SDUIFeedbackPresentationLogic {
    func presentResponse(_ response: SDKUIFeedbackModel.Response) {
        switch response {
        case let .dataView(viewModel): controller?.displayViewModel(.showData(viewModel))
        }
    }
}
