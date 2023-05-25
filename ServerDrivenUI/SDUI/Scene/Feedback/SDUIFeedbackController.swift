//
//  SDUIFeedbackController.swift
//  SDUI
//
//  Created by Julio Junior on 02/03/23.
//

import UIKit
import Coordinator

protocol SDUIFeedbackDisplayLogic: AnyObject {
    func displayViewModel(_ viewModel: SDKUIFeedbackModel.ViewModel)
}

class SDUIFeedbackController: UIViewController {
    
    private let interactor: SDUIFeedbackBusinessLogic
    private let completionHandler: (() -> Void)
    
    required public init?(coder: NSCoder) { nil }
    
    init(
        interactor: SDUIFeedbackBusinessLogic,
        completion: @escaping (() -> Void)
    ) {
        self.interactor = interactor
        self.completionHandler = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: ViewCode
    private let margin: CGFloat = 16
    private lazy var vStack = renderStack(axis: .vertical, spacing: margin, alignment: .center)
    private lazy var titleLabel = renderLabel(font: .preferredFont(forTextStyle: .title1))
    private lazy var subTitleLabel = renderLabel(font: .preferredFont(forTextStyle: .body))
    private lazy var footerStack = renderStack(axis: .vertical, spacing: margin, alignment: .fill)
    private lazy var Button: UIButton = {
        let Button = UIButton(type: .roundedRect)
        Button.tintColor = .white
        Button.backgroundColor = .systemGreen
        Button.layer.cornerRadius = 12
        Button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.doRequest(.fetchData)
    }
    
    private func renderLabel(font: UIFont, textColor: UIColor = .black, alignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    @objc
    func didTap(_ sender: UIButton) {
        completionHandler()
    }
}

// MARK: ViewCodeHelper methods
extension SDUIFeedbackController: ViewCodeHelper {
    
    func buildViewHierarchy() {
        view.addSubview(vStack)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subTitleLabel)
        view.addSubview(footerStack)
        footerStack.addArrangedSubview(Button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
        ])
        
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        
        let bottomSafeArea: CGFloat = keyWindow?.safeAreaInsets.bottom ?? 0
        
        NSLayoutConstraint.activate([
            footerStack.topAnchor.constraint(greaterThanOrEqualTo: vStack.bottomAnchor, constant: margin),
            footerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            footerStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomSafeArea),
            footerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            footerStack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupAdditionalConfiguration() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .white
    }
}

// MARK: SDUIViewPresenterDelegate methods
extension SDUIFeedbackController: SDUIFeedbackDisplayLogic {
    
    func displayViewModel(_ viewModel: SDKUIFeedbackModel.ViewModel) {
        switch viewModel {
        case let .showData(data):
            titleLabel.text = data.title
            subTitleLabel.text = data.subtitle
            Button.setTitle(data.ButtonTitle, for: .normal)
        }
    }

}
