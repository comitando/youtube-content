//
//  SDUIModel.swift
//  SDUI
//
//  Created by Julio Junior on 02/03/23.
//

import Foundation

public enum SDKUIListModel {
    
    public enum Request {
        case fetchData
        case updateData(SDUIEvents)
        case transitionManager
        case postData
    }
    
    public enum Response {
        case isLoading(Bool)
        case dataView(SDUIDTO)
        case transitionManager(SDUILoader)
        case successfullyPost(Error?)
    }
    
    public enum ViewModel {
        case isLoading(Bool)
        case showData(SDUIDTO)
        case sendManager(SDUILoader)
        case finished(Error?)
    }
}
