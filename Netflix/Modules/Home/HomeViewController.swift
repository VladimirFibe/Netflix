import UIKit

class HomeViewController: BaseViewController {
    enum Section: Int, CaseIterable {
        case hero
        case movie
        case trendingMovie
        case trendingTV
        case person
        
        var name: String {
            switch self {
            case .hero: return ""
            case .movie:return "Popular Movie"
            case .trendingMovie:return "Trending Movies"
            case .trendingTV: return "Trending TV"
            case .person: return "Popular People"
            }
        }
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, HomeItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, HomeItem>
    
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
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .logoNetflix, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: .navbarAccount, style: .done, target: self, action: nil),
            UIBarButtonItem(image: .navbarFeatured, style: .done, target: self, action: nil)
        ]
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
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    private func cellRegistrationHandler<T: SelfConfiguringMovieCell>(cell: T, indexPath: IndexPath, movie: Movie) {
        cell.configure(with: movie)
    }
    
    private func headerRegistrationHandler(view: HomeSectionHeader, kind: String, indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        view.configure(with: section.name)
    }
    
    private func personRegistrationHandler(cell: HomePersonCell, indexPath: IndexPath, person: Person) {
        cell.configure(with: person)
    }
    
    private func createDataSource() {
        let heroRegistration = UICollectionView.CellRegistration<HomeHeroCell, Movie>(handler: cellRegistrationHandler)
        let personRegistration = UICollectionView.CellRegistration<HomePersonCell, Person>(handler: personRegistrationHandler)
        let cellRegistration = UICollectionView.CellRegistration<HomeMovieCell, Movie>(handler: cellRegistrationHandler)
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<HomeSectionHeader>(elementKind: UICollectionView.elementKindSectionHeader, handler: headerRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .hero(let movie):
                return collectionView.dequeueConfiguredReusableCell(using: heroRegistration, for: indexPath, item: movie)
            case .movie(let movie):
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: movie)
            case .trendingMovie(let movie):
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: movie)
            case .trendingTV(let movie):
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: movie)
            case .person(let person):
                return collectionView.dequeueConfiguredReusableCell(using: personRegistration, for: indexPath, item: person)
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
            snapshot.appendItems([HomeItem.hero(hero)], toSection: .hero)
            snapshot.appendItems(homeData.movies.map {HomeItem.movie($0)}, toSection: .movie)
            snapshot.appendItems(homeData.trendingMovies.map {HomeItem.trendingMovie($0)}, toSection: .trendingMovie)
            snapshot.appendItems(homeData.trendingTVs.map { HomeItem.trendingTV($0)}, toSection: .trendingTV)
            snapshot.appendItems(homeData.persons.map { HomeItem.person($0)}, toSection: .person)
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
    
    private func createPersonSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(106),
                                               heightDimension: .absolute(106))
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
            case .person: return self.createPersonSection()
            default: return self.createMovieSection()
            }
         }
        return layout
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
