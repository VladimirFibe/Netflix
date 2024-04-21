import UIKit

protocol SelfConfiguringCell {
  static var identifier: String { get }
    func configure(with title: Title)
}

final class BrowseTitleCell: BaseCollectionViewCell, SelfConfiguringCell {
    static let identifier = "BrowseTitleCell"
    private let posterImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(image: .hero))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configure(with title: Title) {
        posterImageView.kf.setImage(with: title.url)
    }
}

extension BrowseTitleCell {
    override func setupViews() {
        contentView.addSubview(posterImageView)
    }
}
