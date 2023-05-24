//
//  FullButtomView.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import UIKit

public final class FullButtomView: SDUIView {
    private lazy var buttom: UIButton = {
        let buttom = UIButton(type: .roundedRect)
        buttom.tintColor = .white
        buttom.backgroundColor = .systemGreen
        buttom.layer.cornerRadius = 12
        buttom.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        buttom.translatesAutoresizingMaskIntoConstraints = false
        return buttom
    }()

    override public func buildViewHierarchy() {
        addSubview(buttom)
    }

    override public func setupConstraints() {
        NSLayoutConstraint.activate([
            buttom.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            buttom.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            buttom.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            buttom.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            buttom.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    override public func setupAdditionalConfiguration() {
        guard let viewModel = viewModel?.get(FullButtomDTO.self) else { return }
        buttom.setTitle(viewModel.title, for: .normal)
        backgroundColor = .white
    }

    @objc func didTap(_ sender: UIButton) {
        guard let item = viewModel?.get(FullButtomDTO.self) else { return }
        delegate?.eventListening(.buttomAction(type: item.action.type, value: item.action.value))
    }
}
