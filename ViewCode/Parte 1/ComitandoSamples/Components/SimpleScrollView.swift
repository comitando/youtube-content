import Foundation
import UIKit

class SimpleScrollView: UIScrollView {
    // MARK: - Private Properties
    private lazy var containerStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.isLayoutMarginsRelativeArrangement = true
        return element
    }()
    
    // MARK: - Inits
    init(spacing: CGFloat = 0,
         margins: NSDirectionalEdgeInsets = .zero) {
        super.init(frame: .zero)
        containerStackView.spacing = spacing
        containerStackView.directionalLayoutMargins = margins
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }

    public func setupAdditionalConfiguration() {

    }
}
