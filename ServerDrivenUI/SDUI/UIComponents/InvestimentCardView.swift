//
//  InvestimentCardView.swift
//  SDUI
//
//  Created by Julio Junior on 27/02/23.
//

import UIKit

public final class InvestimentCardView: SDUIView {
    private lazy var body: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        return view
    }()

    private(set) lazy var vStack: UIStackView = renderStack(axis: .vertical, spacing: 4, alignment: .leading)
    private(set) lazy var title: UILabel = renderLabel(font: .preferredFont(forTextStyle: .title2))
    private(set) lazy var subtitle: UILabel = renderLabel(font: .preferredFont(forTextStyle: .callout))
    private(set) lazy var tagLabel: UILabel = renderLabel(font: .preferredFont(forTextStyle: .body))
    private(set) lazy var vInfoStack: UIStackView = renderStack(axis: .vertical, spacing: 4, alignment: .leading)

    private lazy var buttom: UIButton = {
        let buttom = UIButton(type: .system)
        buttom.translatesAutoresizingMaskIntoConstraints = false
        buttom.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        buttom.tintColor = .systemBlue
        return buttom
    }()

    private func renderLabel(font: UIFont, textColor: UIColor = .black, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func renderStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func createHStack(_ item: InvestimentCardInfo) {
        let hStack: UIStackView = renderStack(axis: .horizontal, spacing: 16, alignment: .leading)

        let title = renderLabel(font: .preferredFont(forTextStyle: .title3))
        title.text = item.title

        let subtitle = renderLabel(font: .preferredFont(forTextStyle: .body))
        subtitle.text = item.subtitle

        hStack.addArrangedSubview(title)
        hStack.addArrangedSubview(subtitle)
        vInfoStack.addArrangedSubview(hStack)
    }

    override public func buildViewHierarchy() {
        addSubview(body)
        body.addSubview(vStack)
        vStack.addArrangedSubview(title)
        vStack.addArrangedSubview(subtitle)
        vStack.addArrangedSubview(tagLabel)
        vStack.addArrangedSubview(vInfoStack)
        vStack.addArrangedSubview(buttom)
    }

    override public func setupConstraints() {
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            body.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            body.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            body.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin)
        ])

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: body.topAnchor, constant: margin),
            vStack.trailingAnchor.constraint(equalTo: body.trailingAnchor, constant: -margin),
            vStack.bottomAnchor.constraint(equalTo: body.bottomAnchor, constant: -margin),
            vStack.leadingAnchor.constraint(equalTo: body.leadingAnchor, constant: margin)
        ])
    }

    override public func setupAdditionalConfiguration() {
        guard let viewModel = viewModel?.get(InvestimentCardDTO.self) else { return }

        title.text = viewModel.title
        subtitle.text = viewModel.subtitle
        tagLabel.text = viewModel.tag

        viewModel.infos.forEach { item in
            createHStack(item)
        }

        buttom.setTitle(viewModel.action?.title, for: .normal)
    }

    @objc func didTap(_ sender: UIButton) {
        guard let item = viewModel?.get(InvestimentCardDTO.self)?.action else { return }
        delegate?.eventListening(.buttomAction(type: item.action.type, value: item.action.value))
    }
}
