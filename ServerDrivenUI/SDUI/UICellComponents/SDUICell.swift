import UIKit

open class SDUICellController: SDUITargetEvent {
    public let viewModel: SDUIDynamic
    private(set) weak var delegate: SDUITargetEvent?

    public required init(viewModel: SDUIDynamic, delegate: SDUITargetEvent? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
    }

    public func registerCell(tableView: UITableView) {}
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    public func eventListening(_ target: SDUITarget) {
        delegate?.eventListening(target)
    }
}

open class SDUICell: UITableViewCell, ViewCodeHelper {
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
        extraConfiguration()
    }

    public func buildViewHierarchy() {}
    public func setupConstraints() {}
    public func setupAdditionalConfiguration() {}

    public func extraConfiguration() {
        selectionStyle = .none
    }
}

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
