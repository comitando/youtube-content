import Foundation

public protocol SDUIBuildableProtocol {
    associatedtype Builder: SDUIBuilderProtocol
}

public protocol SDUIBuilderProtocol: AnyObject {
    var body: [SDUIDynamic] { get set }
}

public extension SDUIBuilderProtocol {
    func isHidden(_ isHidden: () -> Bool) -> Self {
        isHidden() ? emptySelf : self
    }

    func isHidden(_ isHidden: Bool) -> Self {
        isHidden ? emptySelf : self
    }
    var emptySelf: Self {
        let mutableSelf = self
        mutableSelf.body = [SDUIDynamic]()
        return mutableSelf
    }
}

public extension Array where Element == SDUIBuilderProtocol {
    func isHidden(_ isHidden: () -> Bool) -> Self {
        map { $0.isHidden(isHidden) }
    }

    func isHidden(_ isHidden: Bool) -> Self {
        map { $0.isHidden(isHidden) }
    }
}
