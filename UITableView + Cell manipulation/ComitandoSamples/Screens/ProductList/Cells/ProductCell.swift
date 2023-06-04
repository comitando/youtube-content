import UIKit

protocol ProductCellProtocol: AnyObject {
    func didAddProduct(product: Product)
    func didIncrementProduct(product: Product)
    func didDecrementProduct(product: Product)
}

class ProductCell: UITableViewCell {
    
    var quantityOnCart: Int = 0 {
        didSet {
            validateCartStatus()
        }
    }
    
    var product: Product? {
        didSet {
            guard let product else { return }
            
            picture.image = nil
            picture.downloaded(from: product.photo, contentMode: .scaleAspectFill)
            
            nameLabel.attributedText = product.name.getAttributedString()
            descriptionLabel.attributedText = product.description.getAttributedString()
            priceLabel.attributedText = product.priceFormatted().getAttributedString()
            installmentsLabel.attributedText = product.installments.getAttributedString()
        }
    }
    
    weak var delegate: ProductCellProtocol?
    
    private lazy var contentStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isLayoutMarginsRelativeArrangement = true
        element.axis = .vertical
        element.spacing = 5
        return element
    }()
    
    private lazy var productStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isLayoutMarginsRelativeArrangement = true
        element.spacing = 8
        return element
    }()
    
    private lazy var picture: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 8
        element.layer.masksToBounds = true
        return element
    }()
    
    private lazy var productDataStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isLayoutMarginsRelativeArrangement = true
        element.axis = .vertical
        element.spacing = 4
        return element
    }()
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 18)
        element.textColor = .black
        element.numberOfLines = 1
        element.lineBreakMode = .byTruncatingTail
        element.textAlignment = .left
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 11)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 1
        element.lineBreakMode = .byTruncatingTail
        element.textAlignment = .left
        return element
    }()
    
    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 16)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var installmentsLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 11)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var addToCartButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
        element.tintColor = .black
        element.setTitleColor(.white, for: .normal)
        element.configuration = .makeWith(backgroundColor: Asset.Colors.techGreen2.color,
                                          title: Strings.buttonAddToCart,
                                          font: FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 18)!)
        element.layer.cornerRadius = 5
        element.isHidden = quantityOnCart != 0
        return element
    }()
    
    private lazy var cartStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isLayoutMarginsRelativeArrangement = true
        element.spacing = 8
        element.isHidden = quantityOnCart == 0
        return element
    }()

    private lazy var incrementProductButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapIncrementProduct), for: .touchUpInside)
        element.tintColor = .black
        element.setTitleColor(.white, for: .normal)
        element.configuration = .makeWith(backgroundColor: Asset.Colors.techGreen2.color,
                                          title: Strings.buttonAdd,
                                          font: FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 18)!)
        element.layer.cornerRadius = 5
        return element
    }()

    private lazy var decrementProductButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapDecrementProduct), for: .touchUpInside)
        element.tintColor = .black
        element.setTitleColor(.white, for: .normal)
        element.configuration = .makeWith(backgroundColor: Asset.Colors.techGreen2.color,
                                          title: Strings.buttonLess,
                                          font: FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 18)!)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var quantityLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 18)
        element.textColor = .black
        element.numberOfLines = 0
        element.text = "\(quantityOnCart)"
        element.textAlignment = .center
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func validateCartStatus() {
        addToCartButton.isHidden = quantityOnCart != 0
        cartStackView.isHidden = quantityOnCart == 0
        quantityLabel.text = "\(quantityOnCart)"
    }
    
    // MARK: Actions
    
    @objc
    private func didTapAddToCart() {
        guard let product else { return }
        quantityOnCart = 1
        delegate?.didAddProduct(product: product)
    }
    
    @objc
    private func didTapIncrementProduct() {
        guard let product else { return }
        quantityOnCart += 1
        delegate?.didIncrementProduct(product: product)
    }
    
    @objc
    private func didTapDecrementProduct() {
        guard let product else { return }
        quantityOnCart -= 1
        delegate?.didDecrementProduct(product: product)
    }
}

extension ProductCell: ViewCodable {
    func buildViewHierarchy() {
        contentStackView.addArrangedSubview(productStackView)
        contentStackView.addArrangedSubview(addToCartButton)
        contentStackView.addArrangedSubview(cartStackView)

        productStackView.addArrangedSubview(picture)
        productStackView.addArrangedSubview(productDataStackView)

        productDataStackView.addArrangedSubview(nameLabel)
        productDataStackView.addArrangedSubview(descriptionLabel)
        productDataStackView.addArrangedSubview(priceLabel)
        productDataStackView.addArrangedSubview(installmentsLabel)
        
        cartStackView.addArrangedSubview(decrementProductButton)
        cartStackView.addArrangedSubview(quantityLabel)
        cartStackView.addArrangedSubview(incrementProductButton)

        contentView.addSubview(contentStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            picture.widthAnchor.constraint(equalToConstant: 100),
            picture.heightAnchor.constraint(equalToConstant: 100),

            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            contentStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            descriptionLabel.heightAnchor.constraint(equalToConstant: 16),
            priceLabel.heightAnchor.constraint(equalToConstant: 16),
            installmentsLabel.heightAnchor.constraint(equalToConstant: 16),

            addToCartButton.heightAnchor.constraint(equalToConstant: 35),
            cartStackView.heightAnchor.constraint(equalToConstant: 35),
            
            decrementProductButton.widthAnchor.constraint(equalToConstant: 50),
            incrementProductButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupAdditionalConfiguration() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
