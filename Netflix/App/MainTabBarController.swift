import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let home = UINavigationController(rootViewController: UIViewController())
        let upcoming = UINavigationController(rootViewController: UIViewController())
        let search = UINavigationController(rootViewController: UIViewController())
        let downloads = UINavigationController(rootViewController: UIViewController())

        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        upcoming.tabBarItem = UITabBarItem(title: "Coming Soon", image: UIImage(systemName: "play.circle"), tag: 1)
        search.tabBarItem = UITabBarItem(title: "Top Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        downloads.tabBarItem = UITabBarItem(title: "Downloads", image: UIImage(systemName: "arrow.down.to.line"), tag: 3)

        view.backgroundColor = .systemBackground
        setViewControllers([home, upcoming, search, downloads], animated: true)
        
        printMovies()
    }
    
    private func printMovies() {
        let movies = Bundle.main.decode([Movie].self, from: "Movies.json")
        print("static let sampleData: [Movie] = [")
        movies.forEach {
            print(".init(id: \($0.id),")
            print("overview: \"\($0.overview)\",")
            print("posterPath: \"\($0.posterPath)\",")
            print("releaseDate: \"\($0.releaseDate)\",")
            print("title: \"\($0.title)\"")
            print("),")
        }
        print("]")
    }
}
