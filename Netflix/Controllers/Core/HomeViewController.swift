import UIKit











enum Sections: Int {
    case movies
    case tv
    case popular
    case upcoming
    case top
}

class HomeViewController: UIViewController {
//    private var randomTrendingMovie: Title?
    private var headerView: BrowseHeroCell?
    
    let sectionTitles = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top rated"]
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self,
                       forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let useCase = FetchBrowseSectionsUseCase(apiService: APICaller.shared)
        Task {
            do {
                let browse = try await useCase.execute()
                print("DEBUG", browse.movies.count)
            } catch {
                print("DEBUG", error.localizedDescription)
            }
        }
        view.addSubview(homeFeedTable)
        configureNavBar()
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        headerView = BrowseHeroCell(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
    }
    
    private func configureHeroHeaderView() {

        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                if let selectedTitle = titles.randomElement() {
                    self?.headerView?.configure(with: selectedTitle)
                }
                
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar() {
        let image = #imageLiteral(resourceName: "netflixLogo").withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.tintColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        if let section = Sections(rawValue: indexPath.section) {
            switch section {
            case .movies:
                APICaller.shared.getTrendingMovies { result in
                    switch result {
                    case .success(let titles): cell.configure(with: titles)
                    case .failure(let error): print(error.localizedDescription)
                    }
                }
            case .tv:
                APICaller.shared.getTrendingTvs { result in
                    switch result {
                    case .success(let titles): cell.configure(with: titles)
                    case .failure(let error): print(error.localizedDescription)
                    }
                }
            case .popular:
                APICaller.shared.getPopular { result in
                    switch result {
                    case .success(let titles): cell.configure(with: titles)
                    case .failure(let error): print(error.localizedDescription)
                    }
                }
            case .upcoming:
                APICaller.shared.getUpcomingMovies { result in
                    switch result {
                    case .success(let titles): cell.configure(with: titles)
                    case .failure(let error): print(error.localizedDescription)
                    }
                }
            case .top:
                APICaller.shared.getTopRated { result in
                    switch result {
                    case .success(let titles): cell.configure(with: titles)
                    case .failure(let error): print(error.localizedDescription)
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func didTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        let controller = TitlePreviewViewController()
        controller.configure(with: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
