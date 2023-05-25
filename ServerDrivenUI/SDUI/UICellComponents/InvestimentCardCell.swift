import UIKit

public final class InvestimentCardCellController: SDUICellController {
    override public func registerCell(tableView: UITableView) {
        tableView.register(InvestimentCardCell.self, forCellReuseIdentifier: InvestimentCardCell.identifier)
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvestimentCardCell.identifier, for: indexPath) as! InvestimentCardCell
        cell.render(.build(viewModel))
        cell.render(.custom(delegate))
        return cell
    }
}

public final class InvestimentCardCell: SDUICell {
    private lazy var customView: InvestimentCardView = {
        let view = InvestimentCardView()
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

extension InvestimentCardCell: SDUIViewInterface {
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
