import Foundation

public extension SDUIDynamic {
    var identifier: String {
        String(format: "SDUI.%@", id)
    }

    func instantiateView(delegate: SDUITargetEvent? = nil) -> SDUIView? {
        guard let instance = NSClassFromString("\(identifier)View") as? SDUIView.Type else {
            return nil
        }

        let view = instance.init()
        view.render(.build(self))
        view.render(.customDelegate(delegate))

        return view
    }

    func instantiateCellController(delegate: SDUITargetEvent? = nil) -> SDUICellController? {
        guard let instance = NSClassFromString("\(identifier)CellController") as? SDUICellController.Type else {
            return nil
        }

        return instance.init(viewModel: self, delegate: delegate)
    }
}
