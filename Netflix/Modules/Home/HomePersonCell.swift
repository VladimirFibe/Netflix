import UIKit

final class HomePersonCell: BaseCollectionViewCell {
    static var identifier = "HomePersonCell"
    private let posterImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray4
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    func configure(with person: Person) {
        FileStorage.downloadImage(link: person.profileUrl) { image in
            self.posterImageView.image = image
        }
    }
    
    override func setupViews() {
        contentView.addSubview(posterImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
        posterImageView.layer.cornerRadius = posterImageView.frame.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
}
