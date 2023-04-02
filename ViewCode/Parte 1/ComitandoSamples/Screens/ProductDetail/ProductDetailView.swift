import UIKit

final class ProductDetailView: UIView {
    
    // MARK: - Private Properties
    private lazy var scrollView: SimpleScrollView = {
        let element = SimpleScrollView(spacing: 8,
                                       margins: .init(top: 24,
                                                      leading: 24,
                                                      bottom: 24,
                                                      trailing: 24))
        element.showsVerticalScrollIndicator = false
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 20)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.name
        return element
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        element.spacing = 8
        element.alignment = .trailing
        return element
    }()
    
    private lazy var favoriteButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        element.setImage(Asset.Assets.iconFavorite.image, for: .normal)
        return element
    }()
    
    private lazy var shareButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        element.setImage(Asset.Assets.iconShare.image, for: .normal)
        return element
    }()

    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 16)
        element.textColor = Asset.Colors.spaceBlue1.color
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.description
        return element
    }()
    
    private lazy var bullet1ImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = Asset.Assets.bullet.image
        return element
    }()
    
    private lazy var bullet1StackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        return element
    }()

    private lazy var bullet1Label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.bullet1
        return element
    }()
    
    private lazy var bullet2ImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = Asset.Assets.bullet.image
        return element
    }()
    
    private lazy var bullet2StackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        return element
    }()

    private lazy var bullet2Label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.bullet2
        return element
    }()
    
    private lazy var bullet3ImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = Asset.Assets.bullet.image
        return element
    }()
    
    private lazy var bullet3StackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        return element
    }()

    private lazy var bullet3Label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.bullet3
        return element
    }()
    
    private lazy var bullet4ImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = Asset.Assets.bullet.image
        return element
    }()
    
    private lazy var bullet4StackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        return element
    }()

    private lazy var bullet4Label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.bullet4
        return element
    }()
    
    private lazy var bullet5ImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = Asset.Assets.bullet.image
        return element
    }()
    
    private lazy var bullet5StackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        return element
    }()

    private lazy var bullet5Label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.bullet5
        return element
    }()
    
    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 14)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.price
        return element
    }()
    
    private lazy var pixPriceLabel: UILabel = {
        let attributedString = NSMutableAttributedString(string: Strings.pixPrice)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attributedString.length)
        )
        
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 28)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        element.attributedText = attributedString
        
        return element
    }()
    
    private lazy var pixMessageLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 14)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.pixMessage
        return element
    }()
    
    private lazy var installmentsLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 14)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = Strings.installmentsMessage
        return element
    }()
    
    private lazy var buyButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        element.tintColor = .black
        element.setTitle(Strings.buttonBuy, for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.configuration = .makeWith(backgroundColor: Asset.Colors.techGreen2.color,
                                          font: FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 18)!)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var simulateDiscountButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        element.tintColor = .black
        element.setTitle(Strings.buttonSimulateDiscount, for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.configuration = .makeWith(backgroundColor: Asset.Colors.techGreen2.color,
                                          font: FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 18)!)
        element.layer.cornerRadius = 5
        return element
    }()

    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: Actions
    
    @objc
    private func didTapFavorite() {
        
    }
    
    @objc
    private func didTapShare() {
        
    }
    
    @objc
    private func didTapBuy() {
        
    }

    
    // MARK: - Private Methods
    
}

extension ProductDetailView: ViewCodable {
    func buildViewHierarchy() {
        actionsStackView.addArrangedSubview(UIView())
        actionsStackView.addArrangedSubview(favoriteButton)
        actionsStackView.addArrangedSubview(shareButton)
        
        bullet1StackView.addArrangedSubview(bullet1ImageView)
        bullet1StackView.addArrangedSubview(bullet1Label)
        
        bullet2StackView.addArrangedSubview(bullet2ImageView)
        bullet2StackView.addArrangedSubview(bullet2Label)
        
        bullet3StackView.addArrangedSubview(bullet3ImageView)
        bullet3StackView.addArrangedSubview(bullet3Label)
        
        bullet4StackView.addArrangedSubview(bullet4ImageView)
        bullet4StackView.addArrangedSubview(bullet4Label)
        
        bullet5StackView.addArrangedSubview(bullet5ImageView)
        bullet5StackView.addArrangedSubview(bullet5Label)

        scrollView.addSubview(nameLabel)
        scrollView.addSubview(actionsStackView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(bullet1StackView)
        scrollView.addSubview(bullet2StackView)
        scrollView.addSubview(bullet3StackView)
        scrollView.addSubview(bullet4StackView)
        scrollView.addSubview(bullet5StackView)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(pixPriceLabel)
        scrollView.addSubview(pixMessageLabel)
        scrollView.addSubview(installmentsLabel)
        scrollView.addSubview(buyButton)
        scrollView.addSubview(simulateDiscountButton)
        
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        let lg = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: lg.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: lg.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: lg.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        scrollView.backgroundColor = .white
        scrollView.addCustomSpace(spacing: 16, afterView: actionsStackView)
        scrollView.addCustomSpace(spacing: 16, afterView: descriptionLabel)
        scrollView.addCustomSpace(spacing: 4, afterView: bullet1StackView)
        scrollView.addCustomSpace(spacing: 4, afterView: bullet2StackView)
        scrollView.addCustomSpace(spacing: 4, afterView: bullet3StackView)
        scrollView.addCustomSpace(spacing: 4, afterView: bullet4StackView)
        scrollView.addCustomSpace(spacing: 44, afterView: bullet5StackView)
        scrollView.addCustomSpace(spacing: 0, afterView: priceLabel)
        scrollView.addCustomSpace(spacing: 0, afterView: pixPriceLabel)
        scrollView.addCustomSpace(spacing: 0, afterView: pixMessageLabel)
        scrollView.addCustomSpace(spacing: 16, afterView: installmentsLabel)
        scrollView.addCustomSpace(spacing: 16, afterView: buyButton)
    }
}

extension UIButton.Configuration {
    public static func makeWith(backgroundColor: UIColor,
                                title: String = "",
                                font: UIFont,
                                icon: UIImage? = nil,
                                imagePlacement: NSDirectionalRectEdge = .leading) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        let attributeContainer: AttributeContainer = .init([NSAttributedString.Key.font: font])
        configuration.attributedTitle = AttributedString(title, attributes: attributeContainer)
        configuration.image = icon
        configuration.titlePadding = 10
        configuration.imagePadding = 30
        configuration.imagePlacement = imagePlacement
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        configuration.background.backgroundColor = backgroundColor
        return configuration
    }
}
