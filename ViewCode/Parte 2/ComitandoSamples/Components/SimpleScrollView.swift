import Foundation
import UIKit

class SimpleScrollView: UIScrollView {
    // MARK: - Private Properties
    private lazy var containerStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isLayoutMarginsRelativeArrangement = true
        return element
    }()
    
    // MARK: - Inits
    init(spacing: CGFloat = 0,
         margins: NSDirectionalEdgeInsets = .zero,
         axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)
        containerStackView.spacing = spacing
        containerStackView.directionalLayoutMargins = margins
        containerStackView.axis = axis
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Public Methods
    override func addSubview(_ view: UIView) {
        containerStackView.addArrangedSubview(view)
    }
    
    func addCustomSpace(spacing: CGFloat, afterView: UIView) {
        containerStackView.setCustomSpacing(spacing, after: afterView)
    }
}

extension SimpleScrollView: ViewCodable {
    public func buildViewHierarchy() {
        super.addSubview(containerStackView)
    }

    public func setupConstraints() {
        if containerStackView.axis == .vertical {
            NSLayoutConstraint.activate([
                containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                containerStackView.topAnchor.constraint(equalTo: topAnchor),
                containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                containerStackView.widthAnchor.constraint(equalTo: widthAnchor)
            ])
            
            let heightAnchor = containerStackView.heightAnchor.constraint(equalTo: heightAnchor)
            heightAnchor.priority = .defaultLow
            heightAnchor.isActive = true
        } else {
            let spacing = containerStackView.spacing
            NSLayoutConstraint.activate([
                containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -(spacing / 2)),
                containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: spacing / 2),
                containerStackView.topAnchor.constraint(equalTo: topAnchor),
                containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                containerStackView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
            
            let widthAnchor = containerStackView.widthAnchor.constraint(equalTo: widthAnchor)
            widthAnchor.priority = .defaultLow
            widthAnchor.isActive = true
        }
    }

    public func setupAdditionalConfiguration() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}
