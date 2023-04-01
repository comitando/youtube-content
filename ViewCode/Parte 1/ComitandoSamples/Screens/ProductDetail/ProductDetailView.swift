import UIKit

final class ProductDetailView: UIView {
    
    // MARK: - Private Properties
    private lazy var scrollView: SimpleScrollView = {
        let element = SimpleScrollView(spacing: 8,
                                       margins: .init(top: 24,
                                                      leading: 24,
                                                      bottom: 24,
                                                      trailing: 24))
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

    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Private Methods

    
}

extension ProductDetailView: ViewCodable {
    func buildViewHierarchy() {
        scrollView.addSubview(nameLabel)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        let lg = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: lg.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: lg.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: lg.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: lg.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
//        scrollView.addCustomSpace(spacing: 72, afterView: UIView())
    }
}
