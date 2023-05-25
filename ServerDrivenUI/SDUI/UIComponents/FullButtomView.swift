import UIKit

public final class FullButtonView: SDUIView {
    private lazy var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override public func buildViewHierarchy() {
        addSubview(button)
    }

    override public func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    override public func setupAdditionalConfiguration() {
        guard let viewModel = viewModel?.get(FullButtonDTO.self) else { return }
        button.setTitle(viewModel.title, for: .normal)
        backgroundColor = .white
    }

    @objc func didTap(_ sender: UIButton) {
        guard let item = viewModel?.get(FullButtonDTO.self) else { return }
        delegate?.eventListening(.buttonAction(type: item.action.type, value: item.action.value))
    }
}
