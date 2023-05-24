//
//  SDKUIFeedbackFactory.swift
//  SDUI
//
//  Created by Julio Junior on 02/03/23.
//

import UIKit

public final class SDKUIFeedbackFactory {
    
    public static func makeBuilder(dataSource: FeedbackSystem, completion: @escaping (() -> Void)) -> UIViewController {
        
        let presenter = SDUIFeedbackPresenter()
        let interactor = SDUIFeedbackInteractor(dataSource: dataSource, presenter: presenter)
        let controller = SDUIFeedbackController(interactor: interactor, completion: completion)
        presenter.controller = controller
        
        return controller
    }
}
