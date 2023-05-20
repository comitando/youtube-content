import UIKit

class ProductPriceView: UIStackView {
    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 14)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var pixPriceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 28)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var pixMessageLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 14)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var installmentsLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 14)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    init(price: NSAttributedString,
         pixPrice: NSAttributedString,
         pixMessage: NSAttributedString,
         installmentsMessage: NSAttributedString) {
        super.init(frame: .zero)
        priceLabel.attributedText = price
        pixPriceLabel.attributedText = pixPrice
        pixMessageLabel.attributedText = pixMessage
        installmentsLabel.attributedText = installmentsMessage
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ProductPriceView: ViewCodable {
    func buildViewHierarchy() {
        addArrangedSubview(priceLabel)
        addArrangedSubview(pixPriceLabel)
        addArrangedSubview(pixMessageLabel)
        addArrangedSubview(installmentsLabel)
    }
    
    func setupConstraints() { }
    
    func setupAdditionalConfiguration() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
    }
}
