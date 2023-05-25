import Foundation
import SDUI

final class CDBInvestmentValueCompose: SDUILoader {
    
    private let loader: SDUILoader
    private let manager: SDUILoader
    
    init(loader: SDUILoader, manager: SDUILoader) {
        self.loader = loader
        self.manager = manager
    }
    
    func request(_ completion: @escaping ((SDUIDTO) -> Void)) {
        loader.request(completion)
    }
    
    func sendEventData(_ event: SDUIEvents, completion: @escaping ((Error?) -> Void)) {
        manager.sendEventData(event, completion: completion)
    }
}


