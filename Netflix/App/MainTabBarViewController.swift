import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let home = UINavigationController(rootViewController: BrowseViewController())
        let upcoming = UINavigationController(rootViewController: UpcomingViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let downloads = UINavigationController(rootViewController: HomeViewController())
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        upcoming.tabBarItem = UITabBarItem(title: "Coming Soon", image: UIImage(systemName: "play.circle"), tag: 1)
        search.tabBarItem = UITabBarItem(title: "Top Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        downloads.tabBarItem = UITabBarItem(title: "Downloads", image: UIImage(systemName: "arrow.down.to.line"), tag: 3)
        
        view.backgroundColor = .systemBackground
        setViewControllers([home, upcoming, search, downloads], animated: true)
        selectedIndex = 0
    }
}

