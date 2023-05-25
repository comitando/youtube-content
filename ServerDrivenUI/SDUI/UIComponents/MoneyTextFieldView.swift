//
//  MoneyTextFieldView.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import UIKit

public final class MoneyTextFieldView: SDUIView, UITextFieldDelegate {
    private(set) lazy var vStack: UIStackView = renderStack(axis: .vertical, spacing: 16, alignment: .fill)
    private(set) lazy var title: UILabel = renderLabel(font: .preferredFont(forTextStyle: .callout))
    private(set) lazy var errorMessage: UILabel = renderLabel(font: .preferredFont(forTextStyle: .callout), textColor: .darkGray)
    private(set) lazy var hStack: UIStackView = renderStack(axis: .horizontal, spacing: 8, alignment: .fill, distribution: .fillEqually)

    private lazy var textField: UITextField = {
        let text = UITextField()
        text.font = .boldSystemFont(ofSize: 38)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .systemGreen
        text.delegate = self
        return text
    }()

    private func renderLabel(font: UIFont, textColor: UIColor = .black, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func renderStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment
        stack.distribution = distribution
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func addButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.setTitle(title, for: .normal)
        button.tag = tag
        button.tintColor = .systemGreen
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        return button
    }

    private func addValue(_ action: ActionButton) {
        let value = Double(action.value) ?? 0
        let newValue = DecimalFormatter.shared.adding(value: value, currentString: textField.text ?? "")
        textField.text = newValue
        delegate?.eventListening(.sendEventData(type: .newDataValue(newValue)))
    }

    private func newValue(_ action: ActionButton) {
        let value = Double(action.value) ?? 0
        let newValue = DecimalFormatter.shared.adding(value: value, currentString: "")
        textField.text = newValue
        delegate?.eventListening(.sendEventData(type: .newDataValue(newValue)))
    }

    override public func buildViewHierarchy() {
        addSubview(vStack)
        vStack.addArrangedSubview(title)
        vStack.addArrangedSubview(textField)
        vStack.addArrangedSubview(errorMessage)
        vStack.addArrangedSubview(hStack)
    }

    override public func setupConstraints() {
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin)
        ])
    }

    override public func setupAdditionalConfiguration() {
        guard let viewModel = viewModel?.get(TextFieldDTO.self) else { return }

        title.text = viewModel.title
        textField.placeholder = viewModel.placeHolder
        errorMessage.text = viewModel.message

        viewModel.buttons.enumerated().forEach { (index, item) in
            hStack.addArrangedSubview(addButton(title: item.title, tag: index))
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString = (textField.text ?? "") as NSString
        let newValue = DecimalFormatter.shared.currencyFormatterWithoutSymbol(range, string: string, currentString: currentString)
        textField.text = newValue
        return false
    }

    @objc func didTap(_ sender: UIButton) {
        guard let item = viewModel?.get(TextFieldDTO.self)?.buttons[sender.tag] else { return }
        switch item.action.type {
        case .addValue: addValue(item.action)
        case .newValue: newValue(item.action)
        default: break
        }
    }
}
