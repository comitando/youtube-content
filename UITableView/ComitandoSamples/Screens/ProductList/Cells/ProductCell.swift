import UIKit

class ProductCell: UITableViewCell {
    
    var product: Product? {
        didSet {
            guard let product else { return }
            
            picture.image = nil
            picture.downloaded(from: product.photo, contentMode: .scaleAspectFill)
            
            nameLabel.attributedText = product.name.getAttributedString()
            descriptionLabel.attributedText = product.description.getAttributedString()
            priceLabel.attributedText = product.price.getAttributedString()
            installmentsLabel.attributedText = product.installments.getAttributedString()
        }
    }
    
    private lazy var horizontalStackView: UIStackView = {
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
    
    private lazy var verticalStackView: UIStackView = {
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
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 20)
        element.textColor = .black
        element.numberOfLines = 1
        element.textAlignment = .left
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 1
        element.textAlignment = .left
        return element
    }()
    
    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 15)
        element.textColor = .black
        element.numberOfLines = 1
        element.textAlignment = .left
        return element
    }()
    
    private lazy var installmentsLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 1
        element.textAlignment = .left
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension ProductCell: ViewCodable {
    func buildViewHierarchy() {
        horizontalStackView.addArrangedSubview(picture)
        horizontalStackView.addArrangedSubview(verticalStackView)

        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        verticalStackView.addArrangedSubview(priceLabel)
        verticalStackView.addArrangedSubview(installmentsLabel)
        
        contentView.addSubview(horizontalStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            picture.widthAnchor.constraint(equalToConstant: 100),
            picture.heightAnchor.constraint(equalToConstant: 100),

            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            horizontalStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupAdditionalConfiguration() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
