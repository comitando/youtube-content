import UIKit

protocol ProductListViewProtocol {
    func didSelect(product: Product)
    
    func didAddProduct(product: Product)
    func didIncrementProduct(product: Product)
    func didDecrementProduct(product: Product)
}

final class ProductListView: UIView {
    
    private lazy var photoMacUrl = "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery1-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621031697"

    private lazy var photoiPhoneUrl = "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-2-202209_GEO_US?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1660753617560"

    private var cart: [CartItem] = []
    
    private lazy var macs = [
        Product(id: "1",
                photo: photoMacUrl,
                name: "MacBookPro 14\" (1)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: 10.10,
                installments: "em até 10x de R$ 2.314,88 sem juros"),
        Product(id: "2",
                photo: photoMacUrl,
                name: "MacBookPro 14\" (2)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: 10.10,
                installments: "em até 10x de R$ 2.314,88 sem juros"),
        Product(id: "3",
                photo: photoMacUrl,
                name: "MacBookPro 14\" (3)",
                description: "GPU de 16 núcleos, 16GB, 512GB SSD",
                price: 10.10,
                installments: "em até 10x de R$ 2.314,88 sem juros")
    ]

    private lazy var iPhones = [
        Product(id: "4",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (1)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "5",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (2)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão"),
        Product(id: "6",
                photo: photoiPhoneUrl,
                name: "iPhone 14 Pro (3)",
                description: "Tela de 6,1\", 5G, Câmera Tripla de 48MP",
                price: 9.5,
                installments: "em até 5x R$ 1.699,38 no cartão")
    ]
    
    private lazy var categories: [Category] = [
        .init(name: "Macs", items: macs),
        .init(name: "iPhones", items: iPhones)
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
        delegate?.didSelect(product: categories[indexPath.section].items[indexPath.row])
    }
}

// MARK: - UITableViewDataSource

extension ProductListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderSectionView()
        header.setTitle(title: categories[section].name)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let total = categories[section].items.map { $0.price }.reduce(0, +)
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        let totalFormatted = formatter.string(from: total as NSNumber) ?? ""

        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: tableView.frame.size.width,
                                              height: 40))
        
        let label = UILabel()
        label.text = "Total da categoria \(categories[section].name): \(totalFormatted)"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: footerView.topAnchor),
            label.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -24),
            label.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
        ])
        
        return footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return .init()
        }
        
        cell.product = categories[indexPath.section].items[indexPath.row]
        cell.delegate = self
        
        if let cartItem = cart.first(where: { $0.productId == cell.product?.id ?? "" }) {
            cell.quantityOnCart = cartItem.quantity
        } else {
            cell.quantityOnCart = 0
        }
        
        return cell
    }
}

// MARK: - ProductCellProtocol

extension ProductListView: ProductCellProtocol {
    func didAddProduct(product: Product) {
        cart.append(.init(productId: product.id, quantity: 1))
        delegate?.didAddProduct(product: product)
    }
    
    func didIncrementProduct(product: Product) {
        guard let index = cart.firstIndex(where: { $0.productId == product.id }) else {
            return
        }
        cart[index].incrementQuantity()
        delegate?.didIncrementProduct(product: product)
    }
    
    func didDecrementProduct(product: Product) {
        guard let index = cart.firstIndex(where: { $0.productId == product.id }) else {
            return
        }
        
        if cart[index].quantity == 1 {
            cart.remove(at: index)
        } else {
            cart[index].decrementQuantity()
        }
        
        delegate?.didDecrementProduct(product: product)
    }
}
