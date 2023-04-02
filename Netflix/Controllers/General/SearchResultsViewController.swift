import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {

    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public var titles: [Title] = [] {
        didSet { collectionView.reloadData()}
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension SearchResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell()}
        if let poster = titles[indexPath.item].poster_path {
            cell.configure(with: "https://image.tmdb.org/t/p/w500/\(poster)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.item]
        guard let name = title.original_name ?? title.original_title else { return }
        APICaller.shared.getMovie(with: name) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let video): self.delegate?.didTapItem(TitlePreviewViewModel(title: title, video: video))
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}
