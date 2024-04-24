import UIKit

private typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, Movie>
private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSection, Movie>

class HomeViewController: BaseViewController {
    private var sections: [HomeSection] = []
    private var dataSource: DataSource!
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return collectionView
    }()
    private let store = HomeStore()
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach {
            snapshot.appendItems($0.movies, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
// MARK: - Setup Views
extension HomeViewController {
    func cellRegistrationHandler<T: SelfConfiguringMovieCell>(cell: T, indexPath: IndexPath, movie: Movie) {
        cell.configure(with: movie)
    }
    
    func headerRegistrationHandler(view: HomeSectionHeader, kind: String, indexPath: IndexPath) {
        guard let title = sections[indexPath.section].title else { return}
        view.configure(with: title)
    }
    
    func createDataSource() {
        let heroRegistration = UICollectionView.CellRegistration<HomeHeroCell, Movie>(handler: cellRegistrationHandler)
        let movieCellRegistration = UICollectionView.CellRegistration<HomeMovieCell, Movie>(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, movie in
            if indexPath.section == 0 {
                collectionView.dequeueConfiguredReusableCell(using: heroRegistration, for: indexPath, item: movie)
            } else {
                collectionView.dequeueConfiguredReusableCell(using: movieCellRegistration, for: indexPath, item: movie)
            }
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionHeader, handler: headerRegistrationHandler)

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
    }
    
    func createHeroSection(using section: HomeSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(500)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        return layoutSection
    }
    
    func createMovieSection(using section: HomeSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets.trailing = 8
        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(120),
            heightDimension: .absolute(150)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.interItemSpacing = .fixed(8)
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(20)
        )
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { index, environment in
            if index == 0 {
                self.createHeroSection(using: self.sections[index])
            } else {
                self.createMovieSection(using: self.sections[index])
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    override func setupViews() {
        store.sendAction(.fetch)
        view.addSubview(collectionView)
        createDataSource()
    }
    
    override func setupConstraints() {
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
