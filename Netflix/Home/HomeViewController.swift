import UIKit

private typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, Movie>
private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSection, Movie>

class HomeViewController: BaseViewController {
    private var sections: [HomeSection] = []
    private var dataSourse: DataSource!
    private let store = HomeStore()
    private let hero = HomeHeroCell()
    private func reloadData() {
        hero.configure(with: sections[0].movies[0])
    }
}
// MARK: - Setup Views
extension HomeViewController {
    override func setupViews() {
        store.sendAction(.fetch)
        view.addSubview(hero)
        hero.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            hero.topAnchor.constraint(equalTo: view.topAnchor),
            hero.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hero.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hero.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    override func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .didLoad(sections):
                    self.sections = sections
                    self.reloadData()
                }
            }.store(in: &bag)
    }
}
