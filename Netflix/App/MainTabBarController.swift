import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let home = UINavigationController(rootViewController: HomeViewController())
        let upcoming = UINavigationController(rootViewController: UpcomingViewController())
        let fast = UINavigationController(rootViewController: BaseViewController())
        let search = UINavigationController(rootViewController: UIViewController())
        let downloads = UINavigationController(rootViewController: UIViewController())

        home.tabBarItem = UITabBarItem(title: "Home", image: .home, tag: 0)
        upcoming.tabBarItem = UITabBarItem(title: "News & Hot", image: .newsHot, tag: 1)
        fast.tabBarItem = UITabBarItem(title: "Fast Laughs", image: .fastLaughs, tag: 2)
        search.tabBarItem = UITabBarItem(title: "Search", image: .search, tag: 3)
        downloads.tabBarItem = UITabBarItem(title: "Downloads", image: .downloads, tag: 4)

        view.backgroundColor = .systemBackground
        setViewControllers([home, upcoming, fast, search, downloads], animated: true)
    }
}
