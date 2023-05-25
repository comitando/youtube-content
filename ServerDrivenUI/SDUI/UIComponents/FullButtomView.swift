//
//  FullButtonView.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import UIKit

public final class FullButtonView: SDUIView {
    private lazy var Button: UIButton = {
        let Button = UIButton(type: .roundedRect)
        Button.tintColor = .white
        Button.backgroundColor = .systemGreen
        Button.layer.cornerRadius = 12
        Button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()

    override public func buildViewHierarchy() {
        addSubview(Button)
    }

    override public func setupConstraints() {
        NSLayoutConstraint.activate([
            Button.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            Button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            Button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            Button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            Button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    override public func setupAdditionalConfiguration() {
        guard let viewModel = viewModel?.get(FullButtonDTO.self) else { return }
        Button.setTitle(viewModel.title, for: .normal)
        backgroundColor = .white
    }

    @objc func didTap(_ sender: UIButton) {
        guard let item = viewModel?.get(FullButtonDTO.self) else { return }
        delegate?.eventListening(.ButtonAction(type: item.action.type, value: item.action.value))
    }
}
