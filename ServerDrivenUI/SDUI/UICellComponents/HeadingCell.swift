//
//  HeadingCell.swift
//  SDUI
//
//  Created by Julio Junior on 27/02/23.
//

import UIKit

public final class HeadingCellController: SDUICellController {
    override public func registerCell(tableView: UITableView) {
        tableView.register(HeadingCell.self, forCellReuseIdentifier: HeadingCell.identifier)
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeadingCell.identifier, for: indexPath) as! HeadingCell
        cell.render(.build(viewModel))
        return cell
    }
}

public final class HeadingCell: SDUICell {
    private lazy var customView: HeadingView = {
        let view = HeadingView()
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

extension HeadingCell: SDUIViewInterface {
    enum RenderType {
        case build(SDUIDynamic)
    }

    func render(_ type: RenderType) {
        switch type {
        case let .build(viewModel):
            customView.render(.build(viewModel))
        }
    }
}
