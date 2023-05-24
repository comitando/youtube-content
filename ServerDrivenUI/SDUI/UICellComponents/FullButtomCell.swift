//
//  FullButtomCell.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import UIKit

public final class FullButtomCellController: SDUICellController {
    override public func registerCell(tableView: UITableView) {
        tableView.register(FullButtomCell.self, forCellReuseIdentifier: FullButtomCell.identifier)
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FullButtomCell.identifier, for: indexPath) as! FullButtomCell
        cell.render(.build(viewModel))
        cell.render(.custom(delegate))
        return cell
    }
}

public final class FullButtomCell: SDUICell {
    private lazy var customView: FullButtomView = {
        let view = FullButtomView()
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

extension FullButtomCell: SDUIViewInterface {
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
