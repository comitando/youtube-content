//
//  MoneyTextFieldCell.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import UIKit

public final class MoneyTextFieldCellController: SDUICellController {
    override public func registerCell(tableView: UITableView) {
        tableView.register(MoneyTextFieldCell.self, forCellReuseIdentifier: MoneyTextFieldCell.identifier)
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoneyTextFieldCell.identifier, for: indexPath) as! MoneyTextFieldCell
        cell.render(.build(viewModel))
        cell.render(.custom(delegate))
        return cell
    }
}

public final class MoneyTextFieldCell: SDUICell {
    private lazy var customView: MoneyTextFieldView = {
        let view = MoneyTextFieldView()
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

extension MoneyTextFieldCell: SDUIViewInterface {
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