import UIKit

class HomeViewController: BaseViewController {
    enum Section: Int, CaseIterable {
        case hero
        case movie
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Movie>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Movie>
    
    private var dataSource: DataSource!
    private var collectionView: UICollectionView!
    private let useCase = HomeUseCase(apiService: APIClent.shared)
    private lazy var store = HomeStore(useCase: useCase)
    private var homeData = HomeData()
}

//MARK: - Setup Views
extension HomeViewController {
    override func setupViews() {
        super.setupViews()
        setupCollectionView()
        createDataSource()
        store.sendAction(.fetch)
        reloadData()
    }
    
    override func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .didLoad(data):
                    self.homeData = data
                    self.reloadData()
                }
            }.store(in: &bag)
    }
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    private func cellRegistrationHandler<T: SelfConfiguringMovieCell>(cell: T, indexPath: IndexPath, movie: Movie) {
        cell.configure(with: movie)
    }
    
    private func headerRegistrationHandler(view: HomeSectionHeader, kind: String, indexPath: IndexPath) {
        view.configure(with: "Continue Watching for Ellie")
    }
    
    private func createDataSource() {
        let heroRegistration = UICollectionView.CellRegistration<HomeHeroCell, Movie>(handler: cellRegistrationHandler)
        
        let cellRegistration = UICollectionView.CellRegistration<HomeMovieCell, Movie>(handler: cellRegistrationHandler)
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<HomeSectionHeader>(elementKind: UICollectionView.elementKindSectionHeader, handler: headerRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, movie in
            guard let section = Section(rawValue: indexPath.section) else { fatalError() }
            switch section {
            case .hero: return collectionView.dequeueConfiguredReusableCell(using: heroRegistration, for: indexPath, item: movie)
            case .movie: return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: movie)
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
    }
    
    private func reloadData() {
        if let hero = homeData.hero {
            var snapshot = Snapshot()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems([hero], toSection: .hero)
            snapshot.appendItems(homeData.movies, toSection: .movie)
            dataSource.apply(snapshot)
        }
    }
}
//MARK: - Create Layout
extension HomeViewController {
    private func createHeroSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createMovieSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(106),
                                               heightDimension: .absolute(152))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
 
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout{ index, environment in
            guard let section = Section(rawValue: index) else { fatalError() }
            switch section {
            case .hero: return self.createHeroSection()
            case .movie: return self.createMovieSection()            }
         }
        return layout
    }
}
