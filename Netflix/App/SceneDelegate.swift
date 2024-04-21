import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let apiService = HomeService()
        let userCase = HomeUseCase(apiService: apiService)
        let store = HomeStore(useCase: userCase)
        window?.rootViewController = HomeViewController(store: store)
        window?.makeKeyAndVisible()
    }
}

