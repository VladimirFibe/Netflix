import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let home = UINavigationController(rootViewController: HomeViewController())
        let upcoming = UINavigationController(rootViewController: UpcomingViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let downloads = UINavigationController(rootViewController: DownloadsViewController())
        
        home.tabBarItem.image = UIImage(systemName: "house")
        upcoming.tabBarItem.image = UIImage(systemName: "play.circle")
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloads.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        home.title = "Home"
        upcoming.title = "Coming Soon"
        search.title = "Top Search"
        downloads.title = "Downloads"
        
        home.view.backgroundColor = .systemBackground
        upcoming.view.backgroundColor = .systemBackground
        search.view.backgroundColor = .systemBackground
        downloads.view.backgroundColor = .systemBackground
        
        tabBar.tintColor = .label
        
        setViewControllers([home, upcoming, search, downloads], animated: true)
    }
}

