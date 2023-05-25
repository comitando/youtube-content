import Foundation
import SDUI

struct CDBDTO {
    let minValue: Double = 100
    let maxValue: Double = 10000
    var postContent: CDBPost
}

struct CDBPost {
    var value: Double = 0
}

enum CDBError: SDUIEventsError {
    case emptyValue
    case minValue(Double)
    case maxValue(Double)
    
    func message() -> String {
        switch self {
        case .emptyValue: return "Valor não pode ser vazio"
        case let .minValue(value): return "Valor não pode ser menor que \(String(value))"
        case let .maxValue(value): return "Valor não pode ser maior que \(String(value))"
        }
    }
}
