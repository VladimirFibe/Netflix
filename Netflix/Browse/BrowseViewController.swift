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
//        collectionView.delegate = self
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let item = self.viewModel.rows[indexPath.section].items[indexPath.row]
            switch item {
//            case let .banner(banner):
//                let cell: BannerViewCell = collectionView.dequeueReusableCell(for: indexPath)
//                cell.set(rootView: .init(banner: banner), parentViewController: self)
//                return cell
//            case let .category(category):
//                let cell: CategoryViewCell = collectionView.dequeueReusableCell(for: indexPath)
//                cell.set(rootView: .init(category: category), parentViewController: self)
//                return cell
//            case let .restaurant(restaurant):
//                let cell: RestaurantViewCell = collectionView.dequeueReusableCell(for: indexPath)
//                cell.set(rootView: .init(restaurant: restaurant), parentViewController: self)
//                return cell
//            case let .article(article):
//                let cell: ArticleViewCell = collectionView.dequeueReusableCell(for: indexPath)
//                cell.set(rootView: .init(article: article), parentViewController: self)
//                return cell
            case .movies(let element):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
                if let title = element.poster_path {
                    cell.configure(with: "https://image.tmdb.org/t/p/w500/\(title)")
                }
                return cell
            case .tv(let element):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
                if let title = element.poster_path {
                    cell.configure(with: "https://image.tmdb.org/t/p/w500/\(title)")
                }
                return cell
            case .popular(let element):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
                if let title = element.poster_path {
                    cell.configure(with: "https://image.tmdb.org/t/p/w500/\(title)")
                }
                return cell
            case .upcoming(let element):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
                if let title = element.poster_path {
                    cell.configure(with: "https://image.tmdb.org/t/p/w500/\(title)")
                }
                return cell
            case .top(let element):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
                if let title = element.poster_path {
                    cell.configure(with: "https://image.tmdb.org/t/p/w500/\(title)")
                }
                return cell
            }
        }
        
//        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
//            let section = BrowseSectionType(rawValue: indexPath.section)
//            guard section != .banner else { return nil }
//            
//            guard let self = self, let title = self.viewModel.rows[indexPath.section].title  else { return nil }
//            let headerView: BrowseSectionHeaderSupplementaryView = collectionView.dequeueReusableSupplementaryView(
//                ofKind: kind, for: indexPath
//            )
//            let action: NewCallback
//            switch section {
//            case .restaurants:
//                action = self.navigation.onRestaurantsTap
//            case .categories:
//                action = self.navigation.onCategoriesTap
//            case .articles:
//                action = self.navigation.onArticlesTap
//            default:
//                action = {}
//            }
//            headerView.set(rootView: .init(title: title, action: action), parentViewController: self)
//            return headerView
//        }
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
        store.sendAction(.fetch)
        setupObservers()
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

extension UICollectionViewLayout {
    
    static var rowLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layout in
            let categoryItemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(100),
                heightDimension: .estimated(116)
            )
            let categoryItem = NSCollectionLayoutItem(layoutSize: categoryItemSize)

            let categoryGroupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(350),
                heightDimension: .absolute(116)
            )
            let categoryGroup = NSCollectionLayoutGroup.horizontal(layoutSize: categoryGroupSize, subitems: [categoryItem])
            categoryGroup.interItemSpacing = .fixed(8)

            let section = NSCollectionLayoutSection(group: categoryGroup)
//            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 12, leading: 20, bottom: 0, trailing: 0)
            
            return section
        }
    }
}
