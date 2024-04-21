import UIKit

final class BrowseHeroCell: BaseCollectionViewCell {
    static let idetifier = "BrowseHeroCell"
    
    private let heroImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(image: UIImage(named: "heroImage")))
    
    func configure(with title: Title) {
        if let poster = title.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)")
            heroImageView.kf.setImage(with: url)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
}

extension BrowseHeroCell {
    override func setupViews() {
        [heroImageView].forEach { contentView.addSubview($0)}
    }
    
    override func setupConstraints() {
        
    }
}
