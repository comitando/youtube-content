import UIKit

final class ProductDetailView: UIView {
    // MOCK DATA
    private let photos = [
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery1-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621031697",
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery2-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1671149392013",
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery3-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621009330",
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery4-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621014545",
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery5-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621008925",
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery6-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621030352",
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery7-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621020302",
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery8-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621031287",
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery9-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1674769978954"
    ]
    
    
    // MARK: - Private Properties
    private lazy var scrollView = SimpleScrollView(spacing: 8,
                                                   margins: .init(top: 24,
                                                                  leading: 24,
                                                                  bottom: 24,
                                                                  trailing: 24))

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
    
    private lazy var actions = ActionsView()
    
    private lazy var photosScrollView = PhotosScrollView(photos: photos, lateralPadding: 48, spaceBetweenPhotos: 8)
    private lazy var photosCollectionView = PhotosCollectionView(photos: photos, lateralPadding: 48, spaceBetweenPhotos: 8)

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
    private lazy var bullet1 = BulletItemView(labelValue: getAttributedString(from: Strings.bullet1))
    private lazy var bullet2 = BulletItemView(labelValue: getAttributedString(from: Strings.bullet2))
    private lazy var bullet3 = BulletItemView(labelValue: getAttributedString(from: Strings.bullet3))
    private lazy var bullet4 = BulletItemView(labelValue: getAttributedString(from: Strings.bullet4))
    private lazy var bullet5 = BulletItemView(labelValue: getAttributedString(from: Strings.bullet5))
    
    private lazy var productPriceView = ProductPriceView(
        price: getAttributedString(from: Strings.price,
                                   with: [(text: Strings.price,
                                           attributes: [
                                                .strikethroughStyle: NSUnderlineStyle.single.rawValue
                                           ])]),
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
        scrollView.addSubview(photosScrollView)
//        scrollView.addSubview(photosCollectionView)
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
        scrollView.addCustomSpace(spacing: 16, afterView: photosScrollView)
        scrollView.addCustomSpace(spacing: 16, afterView: photosCollectionView)
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
