import UIKit
import SDUI
import CDB
import Coordinator

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        SDUIBuilder.initialize()
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
    }
    
}


final class ViewController: UIViewController {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setTitle("Hub de Investimentos", for: .normal)
        button.addTarget(self, action: #selector(startFunctionsCoordinator), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    @objc func startFunctionsCoordinator() {
        guard let navigation = navigationController else { return }
        coordinator = CDBCoodinator(navigationController: navigation)
        coordinator?.start()
    }
}
