import UIKit

protocol ProductListViewProtocol {
    func didSelect(indexPath: IndexPath)
    func didAddProduct(indexPath: IndexPath)
    func didIncrementProduct(indexPath: IndexPath)
    func didDecrementProduct(indexPath: IndexPath)
}

final class ProductListView: UIView {
    var delegate: ProductListViewProtocol?
    private var content: ProductListViewController.ViewContentList?
    
    // MARK: - Private Properties
    private lazy var tableView: UITableView = {
        let element = UITableView(frame: .zero, style: .grouped)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        element.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        element.separatorStyle = .none
        element.backgroundColor = .white
        element.delegate = self
        element.dataSource = self
        element.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
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
    
    func setContent(content: ProductListViewController.ViewContentList) {
        self.content = content
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func updateCell(cellContent: ProductCell.CellContent) {
        let section = cellContent.indexPath.section
        let row = cellContent.indexPath.row

        content?.categories[section].items[row] = cellContent
        
        tableView.reloadRows(at: [cellContent.indexPath], with: .fade)
    }
    
    private func getCategory(at section: Int) -> ProductListViewController.ViewContent? {
        content?.categories[section]
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
        delegate?.didSelect(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension ProductListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderSectionView()
        header.setTitle(title: getCategory(at: section)?.name ?? "")
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let total = getCategory(at: section)?.items.map { $0.product?.price ?? 0 }.reduce(0, +) ?? 0
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        let totalFormatted = formatter.string(from: total as NSNumber) ?? ""

        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: tableView.frame.size.width,
                                              height: 40))
        
        let label = UILabel()
        label.text = "Total da categoria \(getCategory(at: section)?.name ?? ""): \(totalFormatted)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontConvertible.Font(font: FontFamily.Rockwell.regular, size: 16)
        label.textColor = Asset.Colors.spaceBlue1.color
        footerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -24),
            label.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -40)
        ])
        
        return footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        content?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getCategory(at: section)?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return .init()
        }
        
        cell.content = content?.categories[indexPath.section].items[indexPath.row]
        cell.delegate = self
        
        return cell
    }
}

// MARK: - ProductCellProtocol

extension ProductListView: ProductCellProtocol {
    func didAddProduct(indexPath: IndexPath) {
        delegate?.didAddProduct(indexPath: indexPath)
    }
    
    func didIncrementProduct(indexPath: IndexPath) {
        delegate?.didIncrementProduct(indexPath: indexPath)
    }
    
    func didDecrementProduct(indexPath: IndexPath) {
        delegate?.didDecrementProduct(indexPath: indexPath)
    }
}
