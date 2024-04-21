import UIKit

private typealias DataSource = UICollectionViewDiffableDataSource<BrowseRow, BrowseItem>
private typealias Snapshot = NSDiffableDataSourceSnapshot<BrowseRow, BrowseItem>

final class BrowseViewController: BaseViewController {
    let useCase = FetchBrowseSectionsUseCase(apiService: APICaller.shared)
    private lazy var store = BrowseStore(useCase: useCase)
    private let viewModel = BrowseViewModel()
    private var dataSource: DataSource!
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .rowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(BrowseTitleCell.self, forCellWithReuseIdentifier: BrowseTitleCell.identifier)
        collectionView.register(BrowseHeroCell.self, forCellWithReuseIdentifier: BrowseHeroCell.identifier)
        collectionView.register(BrowseTitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BrowseTitleSupplementaryView.identifier)
        return collectionView
    }()
    
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, wiht title: Title, for indexPath: IndexPath) -> T {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: cellType.identifier,
        for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)")}
      cell.configure(with: title)
      return cell
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let item = self.viewModel.rows[indexPath.section].items[indexPath.row]
            switch item {
            case .hero(let title): return self.configure(BrowseHeroCell.self, wiht: title, for: indexPath)
            case .movies(let title): return self.configure(BrowseTitleCell.self, wiht: title, for: indexPath)
            case .tv(let title): return self.configure(BrowseTitleCell.self, wiht: title, for: indexPath)
            case .popular(let title): return self.configure(BrowseTitleCell.self, wiht: title, for: indexPath)
            case .upcoming(let title): return self.configure(BrowseTitleCell.self, wiht: title, for: indexPath)
            case .top(let title): return self.configure(BrowseTitleCell.self, wiht: title, for: indexPath)
            }
        }
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self,
                  let title = self.viewModel.rows[indexPath.section].title,
                  let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: BrowseTitleSupplementaryView.identifier,
                    for: indexPath
                  ) as? BrowseTitleSupplementaryView else { return nil }
            sectionHeader.configure(with: title)
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = Snapshot()
        let rows = viewModel.rows
        snapshot.appendSections(rows)
        rows.forEach { row in
            snapshot.appendItems(row.items, toSection: row)
            
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.frame
    }
}

extension BrowseViewController {
    override func setupViews() {
        super.setupViews()
        view.addSubview(collectionView)
        configureDataSource()
        configureNavBar()
        store.sendAction(.fetch)
        setupObservers()
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
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .didLoadSections(browse):
                    self.viewModel.browse = browse
                    self.reloadData()
                }
            }.store(in: &bag)
    }
}

extension BrowseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension UICollectionViewLayout {
    
    static var rowLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layout in
            if sectionIndex == 0 {
                let categoryItemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let categoryItem = NSCollectionLayoutItem(layoutSize: categoryItemSize)
                
                let categoryGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(500)
                )
                let categoryGroup = NSCollectionLayoutGroup.horizontal(layoutSize: categoryGroupSize, subitems: [categoryItem])
                
                let section = NSCollectionLayoutSection(group: categoryGroup)
                section.orthogonalScrollingBehavior = .continuous
                return section
            } else {
                let categoryItemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(150)
                )
                let categoryItem = NSCollectionLayoutItem(layoutSize: categoryItemSize)
                
                let categoryGroupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(350),
                    heightDimension: .absolute(150)
                )
                let categoryGroup = NSCollectionLayoutGroup.horizontal(layoutSize: categoryGroupSize, subitems: [categoryItem])
                categoryGroup.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: categoryGroup)
                section.boundarySupplementaryItems = [header]
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                return section
            }
        }
    }
    
    static var header: NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(54)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader, 
            alignment: .top
        )
    }
}
