//
//  Coordinator.swift
//  Coordinator
//
//  Created by Julio Junior on 28/02/23.
//

import UIKit

public protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
    
    func start()
    func finish()
}

public extension Coordinator {
    
    static func instance(parent: Coordinator? = nil,
                         navigationController: UINavigationController) -> Self {
        let coordinator = Self.init(navigationController: navigationController)
        coordinator.parent = parent
        parent?.childCoordinators.append(coordinator)
        return coordinator
    }
    
    func finishCoordinator(_ child: Coordinator) {
        guard let parent = parent else {
            return
        }
        
        for (index, coordinator) in parent.childCoordinators.enumerated() {
            if coordinator === child {
                parent.childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
