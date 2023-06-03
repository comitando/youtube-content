public protocol ViewCodable: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

public extension ViewCodable {
    func setupView() {
        buildViewHierarchy()

        setupConstraints()

        setupAdditionalConfiguration()
    }
}
