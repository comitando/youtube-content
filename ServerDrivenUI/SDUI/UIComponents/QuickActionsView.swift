//
//  QuickActionsView.swift
//  SDUI
//
//  Created by Julio Junior on 24/02/23.
//

import UIKit

public final class QuickActionsView: SDUIView {
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private func addButton(title: String, tag: Int) -> UIButton {
        let Button = UIButton(type: .roundedRect)
        Button.setTitle(title, for: .normal)
        Button.tag = tag
        Button.tintColor = .black
        Button.backgroundColor = .lightGray
        Button.layer.cornerRadius = 4
        Button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        return Button
    }

    override public func buildViewHierarchy() {
        addSubview(hStack)
    }

    override public func setupConstraints() {
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin)
        ])
    }

    override public func setupAdditionalConfiguration() {
        guard let viewModel = viewModel?.get(QuickActionsDTO.self) else { return }
        hStack.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
            hStack.removeArrangedSubview(view)
        }

        viewModel.items.enumerated().forEach { (index, data) in
            hStack.addArrangedSubview(addButton(title: data.title, tag: index))
        }
    }

    @objc func didTap(_ sender: UIButton) {
        guard let item = viewModel?.get(QuickActionsDTO.self)?.items[sender.tag] else { return }
        delegate?.eventListening(.ButtonAction(type: item.action.type, value: item.action.value))
    }
}
