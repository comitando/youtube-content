import Foundation

protocol ViewModelInterface {
    func loadService()
}

final class ListViewModel: ViewModelInterface {
    
    private let network: NetworkClient
    private let url: URL
    init(network: NetworkClient, url: URL) {
        self.network = network
        self.url = url
    }
    
    var onFeedItem: (([FeedItem]) -> Void)?

    func loadService() {
        network.request(from: url) { [weak self] result in
            switch result {
            case let .success(data): self?.onFeedItem?(ListViewModel.successfullyValidation(data))
            default: self?.onFeedItem?([])
            }
        }
    }
    
    private static func successfullyValidation(_ data: Data) -> [FeedItem] {
        guard let json = try? JSONDecoder().decode(FeedRoot.self, from: data) else {
            return []
        }
        return json.list
    }
}

struct FeedRoot: Codable {
    let list: [FeedItem]
}

struct FeedItem: Codable {
    let title: String
    let description: String
    let imageUrl: String
}
