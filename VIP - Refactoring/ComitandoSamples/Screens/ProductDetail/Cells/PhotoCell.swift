import UIKit

class PhotoCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 8
        element.layer.masksToBounds = true
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func updatePhoto(photoUrl: String) {
        imageView.image = nil
        imageView.downloaded(from: photoUrl, contentMode: .scaleAspectFill)
    }
}

extension PhotoCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {

    }
}
