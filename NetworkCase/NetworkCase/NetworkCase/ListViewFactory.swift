import UIKit

protocol Creator {
    static func makeWithURLSessionController() -> UIViewController
    static func makeWithAlamofireController() -> UIViewController
}

enum ListViewFactory: Creator {
    static func makeWithURLSessionController() -> UIViewController {
        let urlSession = URLSessionManager()
        return makeController(title: "URLSession List", network: urlSession)
    }
    
    static func makeWithAlamofireController() -> UIViewController {
        let alamofire = AlamofireManager()
        return makeController(title: "Alamofire List", network: alamofire)
    }
    
    private static func makeController(title: String, network: NetworkClient) -> UIViewController {
        let url = URL(string: "https://raw.githubusercontent.com/comitando/youtube-content/main/NetworkCase/api/list-sample.json")!
        let viewModel = ListViewModel(network: network, url: url)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        controller.titleName = title
        controller.viewModel = viewModel
        viewModel.onFeedItem = adaptFeedItemToCellController(controller: controller, network: network)
        return controller
    }
    
    private static func adaptFeedItemToCellController(controller: ListViewController, network: NetworkClient) -> ([FeedItem]) -> Void {
        return { [weak controller] items in
            controller?.cellController = items.map { FeedCellController(viewModel: $0, imageNetwork: network) }
        }
    }
}
