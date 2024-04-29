import UIKit

final class UpcomingViewController: BaseViewController {
    private var movies = Bundle.main.decode([Movie].self, from: "Movies.json")
    enum Section: Int {
        case movie
    }
    typealias DataSource = UITableViewDiffableDataSource<Section, Movie>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Movie>
    private var dataSource: DataSource!
    private var tableView: UITableView = {
        $0.register(UpcomingCell.self, forCellReuseIdentifier: UpcomingCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
}

extension UpcomingViewController {
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
        createDataSource()
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createDataSource() {
        dataSource = DataSource(tableView: tableView) { (tableView: UITableView, indexPath: IndexPath, movie: Movie) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingCell.identifier, for: indexPath) as? UpcomingCell else { fatalError() }
            cell.configure(with: movie)
            return cell
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([.movie])
        snapshot.appendItems(movies, toSection: .movie)
        dataSource.apply(snapshot, animatingDifferences: false)
        tableView.dataSource = dataSource
    }
}
