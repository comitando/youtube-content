//
//  SDUIViewUseCase.swift
//  SDUI
//
//  Created by Julio Junior on 02/03/23.
//

import UIKit

public protocol SDUILoader {
    func request(_ completion: @escaping ((SDUIDTO) -> Void))
    func sendEventData(_ event: SDUIEvents, completion: @escaping ((Error?) -> Void))
    func validateToSDUI(_ data: Data) -> Bool
    func adapteeToSDUI(_ data: Data) -> SDUIDTO
}

public extension SDUILoader {
    
    private func decode(_ data: Data) -> SDUIDTO? {
        guard let json = try? JSONDecoder().decode(SDUIDTO.self, from: data) else {
            return nil
        }
        return json
    }
    
    func validateToSDUI(_ data: Data) -> Bool {
        return decode(data) != nil
    }
    
    func adapteeToSDUI(_ data: Data) -> SDUIDTO {
        return decode(data)!
    }
    
    func sendEventData(_ event: SDUIEvents, completion: @escaping ((Error?) -> Void)) {}
    func request(_ completion: @escaping ((SDUIDTO) -> Void)) {}
}

public enum SDUIEvents {
    case newDataValue(String)
    case postData
}

public protocol SDUIEventsError {
    func message() -> String
}

public enum SDUITarget {
    case buttonAction(type: ActionButtonType, value: String)
    case sendEventData(type: SDUIEvents)
}

public protocol SDUITargetEvent: AnyObject {
    func eventListening(_ target: SDUITarget)
}

public protocol SDUICoodinatorRouter {
    func onBack(_ current: UIViewController)
    func onNext(_ current: UIViewController, type: ActionButtonType, value: String)
    func onNext(_ current: UIViewController, manager: SDUILoader)
}

public extension SDUICoodinatorRouter {
    func onBack(_ current: UIViewController) {}
    func onNext(_ current: UIViewController, type: ActionButtonType, value: String) {}
    func onNext(_ current: UIViewController, manager: SDUILoader) {}
}
