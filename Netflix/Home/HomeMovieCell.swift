import UIKit

final class HomeMovieCell: BaseCollectionViewCell, SelfConfiguringMovieCell {
    static var identifier = "HomeMovieCell"
    private let posterImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray4
        return $0
    }(UIImageView())
    
    func configure(with movie: Movie) {
        FileStorage.downloadImage(link: movie.posterUrl) { image in
            self.posterImageView.image = image
        }
    }
    
    override func setupViews() {
        contentView.addSubview(posterImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
}
