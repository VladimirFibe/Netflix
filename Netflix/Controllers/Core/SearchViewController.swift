import UIKit

class SearchViewController: UIViewController {
    var titles: [Title] = []
    lazy var tableView = UITableView().apply {
        $0.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
        
    }
    
    private lazy var searchController = UISearchController(searchResultsController: SearchResultsViewController()).apply {
        $0.searchBar.placeholder = "Search for a Moview or a TV show"
        $0.searchBar.searchBarStyle = .minimal
        $0.searchResultsUpdater = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Seach"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
        view.addSubview(tableView)
        
        fetchDescover()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchDescover() {
        APICaller.shared.getDiscoverMovies {[weak self] result in
            switch result {
            case .success(let titles): DispatchQueue.main.async {
                self?.titles = titles
                self?.tableView.reloadData()
            }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
        else { return UITableViewCell()}
        cell.configure(with: TitleViewModel(title: titles[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.item]
        guard let name = title.original_name ?? title.original_title else { return }
        APICaller.shared.getMovie(with: name) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let video):
                    let controller = TitlePreviewViewController()
                    let title = self.titles[indexPath.row]
                    controller.configure(with: TitlePreviewViewModel(title: title, video: video))
                    self.navigationController?.pushViewController(controller, animated: true)
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController
        else { return }
        resultsController.delegate = self
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapItem(_ viewModel: TitlePreviewViewModel) {
        let controller = TitlePreviewViewController()
        controller.configure(with: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
