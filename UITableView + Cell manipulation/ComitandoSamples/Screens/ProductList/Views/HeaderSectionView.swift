import UIKit

final class HeaderSectionView: UIStackView {
    // MARK: - Private Properties
    
    private lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.bold, size: 20)
        element.textColor = Asset.Colors.techGreen2.color
        element.numberOfLines = 1
        element.textAlignment = .left
        return element
    }()
    
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = ColorAsset.Color.lightGray
        element.alpha = 0.5
        return element
    }()
    
    func setTitle(title: String) {
        label.attributedText = title.getAttributedString()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - ViewCodable

extension HeaderSectionView: ViewCodable {
    func buildViewHierarchy() {
        addArrangedSubview(label)
        addArrangedSubview(lineView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 20),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        isLayoutMarginsRelativeArrangement = true
        spacing = 0
        distribution = .fill
        axis = .vertical
        directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
    }
}
