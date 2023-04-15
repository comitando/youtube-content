import UIKit

class ActionsView: UIStackView {
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
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapFavorite() {
        
    }
    
    @objc
    private func didTapShare() {
        
    }
}

extension ActionsView: ViewCodable {
    func buildViewHierarchy() {
        addArrangedSubview(UIView())
        addArrangedSubview(favoriteButton)
        addArrangedSubview(shareButton)
    }
    
    func setupConstraints() { }
    
    func setupAdditionalConfiguration() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        spacing = 8
        alignment = .trailing
    }
}
