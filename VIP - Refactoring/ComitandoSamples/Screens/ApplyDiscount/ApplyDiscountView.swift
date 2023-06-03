import UIKit

protocol ApplyDiscountViewOutputProtocol {
    func applyDiscount(value: String)
}

protocol ApplyDiscountViewInputProtocol {
    func setProductLabel(text: String)
    func setInfoLabel(text: String)
    func showPriceWithDiscount(message: String)
    func showErrorMessage(message: String)
}

class ApplyDiscountView: UIView {
    
    var delegate: ApplyDiscountViewOutputProtocol?
    
    // MARK: - Private Properties
    private lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.alignment = .center
        element.spacing = 16
        return element
    }()
    
    private lazy var productLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .black
        element.font = .boldSystemFont(ofSize: 16)
        element.numberOfLines = 0
        element.textAlignment = .center
        return element
    }()

    private lazy var valueTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "10%"
        element.borderStyle = .roundedRect
        element.keyboardType = .numberPad
        element.layer.cornerRadius = 5
        element.rightViewMode = .always
        element.textAlignment = .center
        return element
    }()
    
    private lazy var infoLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .systemGray
        element.font = .systemFont(ofSize: 11)
        element.numberOfLines = 0
        element.textAlignment = .center
        return element
    }()

    private lazy var button: UIButton = {
        let element = UIButton()
        element.setTitle("Aplicar Desconto", for: .normal)
        element.backgroundColor = .systemBlue
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 5
        element.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return element
    }()

    private lazy var productWithDiscountLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .black
        element.font = .systemFont(ofSize: 16)
        element.textColor = .blue
        element.numberOfLines = 0
        element.textAlignment = .center
        element.isHidden = true
        return element
    }()
    
    // MARK: - Actions

    @objc
    func didTapButton() {
        delegate?.applyDiscount(value: valueTextField.text ?? "0")
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Private Methods

    func buildViewHierarchy() {
        addSubview(stackView)
        [productLabel,
         valueTextField,
         infoLabel,
         button,
         productWithDiscountLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueTextField.widthAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setupAdditionalConfiguration() {
        stackView.setCustomSpacing(4, after: valueTextField)
        stackView.setCustomSpacing(40, after: infoLabel)
    }
}

extension ApplyDiscountView: ApplyDiscountViewInputProtocol {
    func setProductLabel(text: String) {
        productLabel.text = text
    }
    
    func setInfoLabel(text: String) {
        infoLabel.text = text
    }
    
    func showPriceWithDiscount(message: String) {
        productWithDiscountLabel.textColor = .green
        productWithDiscountLabel.text = message
        productWithDiscountLabel.isHidden = false
    }
    
    func showErrorMessage(message: String) {
        productWithDiscountLabel.textColor = .red
        productWithDiscountLabel.text = message
        productWithDiscountLabel.isHidden = false
    }
}
