//
//  HeadingView.swift
//  SDUI
//
//  Created by Julio Junior on 24/02/23.
//

import UIKit

public final class HeadingView: SDUIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    override public func buildViewHierarchy() {
        addSubview(label)
    }

    override public func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin)
        ])
    }

    override public func setupAdditionalConfiguration() {
        label.text = viewModel?.get(HeadingDTO.self)?.title
    }
}
