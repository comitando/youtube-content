import UIKit

final class ListViewController: UITableViewController {
    
    var titleName: String?
    var viewModel: ViewModelInterface?
    var cellController: [FeedCellController] = [] {
        didSet { DispatchQueue.main.async { [weak self] in self?.tableView.reloadData() } }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleName
        viewModel?.loadService()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellController.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellController[indexPath.row].cancelRequest()
    }
    
}

protocol FeedCellControllerInterface {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func cancelRequest()
}

final class FeedCellController: FeedCellControllerInterface {
    
    let viewModel: FeedItem
    let imageNetwork: NetworkClient
    private var task: NetworkClientTask?
    
    init(viewModel: FeedItem, imageNetwork: NetworkClient) {
        self.viewModel = viewModel
        self.imageNetwork = imageNetwork
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell
        cell?.feedTitle.text = viewModel.title
        cell?.feedDescription.text = viewModel.description
        downloadImage(cell?.feedImage)
        return cell ?? UITableViewCell()
    }
    
    func cancelRequest() {
        task?.cancel()
    }
    
    private func downloadImage(_ feedImage: UIImageView?) {
        feedImage?.image = nil
        if let url = URL(string: viewModel.imageUrl) {
            task = imageNetwork.request(from: url) { result in
                switch result {
                case let .success(data): DispatchQueue.main.async { feedImage?.image = UIImage(data: data) }
                default: break
                }
            }
        }
    }
    
}

final class FeedCell: UITableViewCell {
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedTitle: UILabel!
    @IBOutlet weak var feedDescription: UILabel!
}
