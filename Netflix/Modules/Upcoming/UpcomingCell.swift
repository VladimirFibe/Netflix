import UIKit

final class UpcomingCell: BaseTableViewCell {
    static var identifier = "UpcomingCell"
    private let posterImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray4
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = AppFont.bold.s12
        return $0
    }(UILabel())
    
    private let button: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = .upcomingPlayButton
        $0.configuration = config
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    
    func configure(with movie: Movie) {
        FileStorage.downloadImage(link: movie.backdropUrl) { image in
            self.posterImageView.image = image
        }
        titleLabel.text = movie.titleString
    }
    
    override func setupViews() {
        [posterImageView, titleLabel, button].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 54),
            posterImageView.widthAnchor.constraint(equalToConstant: 90),
            
            titleLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            
            button.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            button.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
}

#Preview {
    UpcomingViewController()
}
