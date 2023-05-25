import UIKit

public final class FullButtonCellController: SDUICellController {
    override public func registerCell(tableView: UITableView) {
        tableView.register(FullButtonCell.self, forCellReuseIdentifier: FullButtonCell.identifier)
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FullButtonCell.identifier, for: indexPath) as! FullButtonCell
        cell.render(.build(viewModel))
        cell.render(.custom(delegate))
        return cell
    }
}

public final class FullButtonCell: SDUICell {
    private lazy var customView: FullButtonView = {
        let view = FullButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public func buildViewHierarchy() {
        contentView.addSubview(customView)
    }

    override public func setupConstraints() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}

extension FullButtonCell: SDUIViewInterface {
    enum RenderType {
        case build(SDUIDynamic)
        case custom(SDUITargetEvent?)
    }

    func render(_ type: RenderType) {
        switch type {
        case let .build(viewModel):
            customView.render(.build(viewModel))
        case let .custom(delegate):
            customView.render(.customDelegate(delegate))
        }
    }
}
