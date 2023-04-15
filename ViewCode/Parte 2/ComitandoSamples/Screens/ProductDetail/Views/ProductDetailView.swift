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
        element.attributedText = getAttributedString(from: Strings.name)
        return element
    }()
    
    private lazy var actions: ActionsView = .init()

    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 16)
        element.textColor = Asset.Colors.spaceBlue1.color
        element.numberOfLines = 0
        element.textAlignment = .left
        element.attributedText = getAttributedString(from: Strings.description)
        return element
    }()
    
    // Bullets
    private lazy var bullet1: BulletItemView = . init(labelValue: getAttributedString(from: Strings.bullet1))
    private lazy var bullet2: BulletItemView = . init(labelValue: getAttributedString(from: Strings.bullet2))
    private lazy var bullet3: BulletItemView = . init(labelValue: getAttributedString(from: Strings.bullet3))
    private lazy var bullet4: BulletItemView = . init(labelValue: getAttributedString(from: Strings.bullet4))
    private lazy var bullet5: BulletItemView = . init(labelValue: getAttributedString(from: Strings.bullet5))
    
    private lazy var productPriceView: ProductPriceView = .init(
        price: getAttributedString(from: Strings.price),
        pixPrice: getAttributedString(from: Strings.pixPrice),
        pixMessage: getAttributedString(from: Strings.pixMessage,
                                        with: [(text: Strings.pixHighlight,
                                                attributes: [
                                                    .foregroundColor: Asset.Colors.techGreen2.color
                                                ])]),
        installmentsMessage: getAttributedString(from: Strings.installmentsMessage)
    )

    private lazy var buyButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        element.tintColor = .black
        element.setTitleColor(.white, for: .normal)
        element.configuration = .makeWith(backgroundColor: Asset.Colors.techGreen2.color,
                                          title: Strings.buttonBuy,
                                          font: FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 18)!)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var simulateDiscountButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        element.tintColor = .black
        element.setTitleColor(.white, for: .normal)
        element.configuration = .makeWith(backgroundColor: Asset.Colors.techGreen2.color,
                                          title: Strings.buttonSimulateDiscount,
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
    private func didTapBuy() {
        
    }

    
    // MARK: - Private Methods
    
    func getAttributedString(from value: String,
                             with highlights: [(text: String,
                                                attributes: [NSAttributedString.Key: Any])]? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: value)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attributedString.length)
        )
        
        if let highlights {
            highlights.forEach { item in
                attributedString.addAttributes(item.attributes,
                                               range: NSString(string: value).range(of: item.text))
            }
        }
        
        return attributedString
    }
}

extension ProductDetailView: ViewCodable {
    func buildViewHierarchy() {
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(actions)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(bullet1)
        scrollView.addSubview(bullet2)
        scrollView.addSubview(bullet3)
        scrollView.addSubview(bullet4)
        scrollView.addSubview(bullet5)
        scrollView.addSubview(productPriceView)
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
        scrollView.addCustomSpace(spacing: 16, afterView: actions)
        scrollView.addCustomSpace(spacing: 16, afterView: descriptionLabel)
        scrollView.addCustomSpace(spacing: 4, afterView: bullet1)
        scrollView.addCustomSpace(spacing: 4, afterView: bullet2)
        scrollView.addCustomSpace(spacing: 4, afterView: bullet3)
        scrollView.addCustomSpace(spacing: 4, afterView: bullet4)
        scrollView.addCustomSpace(spacing: 44, afterView: bullet5)
        scrollView.addCustomSpace(spacing: 16, afterView: productPriceView)
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
