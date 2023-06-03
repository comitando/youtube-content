import UIKit

class BulletItemView: UIStackView {
    private lazy var icon: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = Asset.Assets.bullet.image
        return element
    }()
    
    private lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    init(labelValue: NSAttributedString) {
        super.init(frame: .zero)
        label.attributedText = labelValue
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BulletItemView: ViewCodable {
    func buildViewHierarchy() {
        addArrangedSubview(icon)
        addArrangedSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupAdditionalConfiguration() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
    }
}
