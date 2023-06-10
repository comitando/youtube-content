import UIKit

protocol CartViewProtocol {
    func didIncrement(cartItem: CartItem)
    func didDecrement(cartItem: CartItem)
}

final class CartView: UIView, UITableViewDelegate {
    var delegate: CartViewProtocol?
    private var cartItems: [CartItem] = []
    
    // MARK: - Private Properties
    private lazy var tableView: UITableView = {
        let element = UITableView(frame: .zero, style: .plain)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        element.register(CartCell.self, forCellReuseIdentifier: "CartCell")
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
    
    func setCartItems(cartItems: [CartItem]) {
        self.cartItems = cartItems
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func updateCell(item: CartItem) {
        guard let index = cartItems.firstIndex(of: item) else { return }

        cartItems[index] = item
        
        tableView.reloadRows(at: [.init(row: index, section: 0)], with: .fade)
    }
}

// MARK: - ViewCodable

extension CartView: ViewCodable {
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

// MARK: - UITableViewDataSource

extension CartView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartCell else {
            return .init()
        }
        
        cell.cartItem = cartItems[indexPath.row]
        cell.delegate = self
        
        return cell
    }
}

// MARK: - CartCellProtocol

extension CartView: CartCellProtocol {
    func didIncrement(cartItem: CartItem) {
        delegate?.didIncrement(cartItem: cartItem)
    }
    
    func didDecrement(cartItem: CartItem) {
        delegate?.didDecrement(cartItem: cartItem)
    }
}
