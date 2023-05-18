import UIKit

protocol ProductListViewProtocol {
    func didSelect(product: Product)
}

final class ProductListView: UIView {
    // MOCK DATA
    private lazy var productNames = [
        "MacBookPro 14\" (1)",
        "MacBookPro 14\" (2)",
        "MacBookPro 14\" (3)",
        "MacBookPro 14\" (4)",
        "MacBookPro 14\" (5)",
        "MacBookPro 14\" (6)",
        "MacBookPro 14\" (7)",
        "MacBookPro 14\" (8)",
    ]
    
    private lazy var photoUrl = "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery1-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621031697"
    
    private lazy var products = [
        Product(photo: photoUrl,
                name: "MacBookPro 14\" (1)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: "R$ 23.148,82",
                installments: "em até 10x de R$ 2.314,88 sem juros"),
        Product(photo: photoUrl,
                name: "MacBookPro 14\" (2)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: "R$ 23.148,82",
                installments: "em até 10x de R$ 2.314,88 sem juros"),
        Product(photo: photoUrl,
                name: "MacBookPro 14\" (3)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: "R$ 23.148,82",
                installments: "em até 10x de R$ 2.314,88 sem juros"),
        Product(photo: photoUrl,
                name: "MacBookPro 14\" (4)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: "R$ 23.148,82",
                installments: "em até 10x de R$ 2.314,88 sem juros"),
        Product(photo: photoUrl,
                name: "MacBookPro 14\" (5)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: "R$ 23.148,82",
                installments: "em até 10x de R$ 2.314,88 sem juros"),
        Product(photo: photoUrl,
                name: "MacBookPro 14\" (6)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: "R$ 23.148,82",
                installments: "em até 10x de R$ 2.314,88 sem juros")
    ]
    
    var delegate: ProductListViewProtocol?
    
    // MARK: - Private Properties
    private lazy var tableView: UITableView = {
        let element = UITableView(frame: .zero)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        element.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        element.separatorStyle = .none
        element.backgroundColor = .white
        element.delegate = self
        element.dataSource = self
        element.estimatedRowHeight = 44
        element.rowHeight = UITableView.automaticDimension
        
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
}

// MARK: - ViewCodable

extension ProductListView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        let lg = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lg.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: lg.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: lg.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {

    }
}

// MARK: - UITableViewDelegate

extension ProductListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(product: products[indexPath.row])
    }
}

// MARK: - UITableViewDataSource

extension ProductListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
//            return .init()
//        }
//
//        var content = cell.defaultContentConfiguration()
//        content.text = productNames[indexPath.row]
//
//        cell.contentConfiguration = content
//        cell.accessoryType = .disclosureIndicator
//        return cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return .init()
        }
        
        cell.product = products[indexPath.row]
        
        return cell
    }
}
