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
        if let url = URL(string: movie.posterUrl) {
            let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
            downloadQueue.async {
                if let data = NSData(contentsOf: url), let image = UIImage(data: data as Data) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = image
                    }
                }
            }
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
