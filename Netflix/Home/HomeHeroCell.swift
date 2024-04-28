import UIKit

final class HomeHeroCell: BaseCollectionViewCell, SelfConfiguringMovieCell {
    static var identifier = "HomeHeroCell"
    
    private let addButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = .myList
        var attText = AttributedString("My List")
        attText.font = AppFont.medium.s12
        config.attributedTitle = attText
        config.imagePlacement = .top
        config.baseForegroundColor = .white
        config.imagePadding = 4
        $0.configuration = config
        return $0
    }(UIButton(type: .system))
    
    private let playButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = .play
        var attText = AttributedString("Play")
        attText.font = AppFont.medium.s14
        config.attributedTitle = attText
        config.imagePlacement = .leading
        config.baseForegroundColor = .black
        config.imagePadding = 8
        $0.configuration = config
        return $0
    }(UIButton(type: .system))
    
    private let infoButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = .info
        config.cornerStyle = .fixed
        config.background.cornerRadius = 2
        var attText = AttributedString("Info")
        attText.font = AppFont.medium.s12
        config.attributedTitle = attText
        config.imagePlacement = .top
        config.baseForegroundColor = .white
        config.imagePadding = 4
        $0.configuration = config
        return $0
    }(UIButton(type: .system))
    
    private let posterImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray4
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let bottomStackView: UIStackView = {
        $0.distribution = .equalSpacing
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    func configure(with movie: Movie) {
        FileStorage.downloadImage(link: movie.posterUrl) { image in
            self.posterImageView.image = image
        }
    }
    
    override func setupViews() {
        [posterImageView, bottomStackView].forEach {
            contentView.addSubview($0)
        }
        [addButton, playButton, infoButton].forEach {
            bottomStackView.addArrangedSubview($0)
        }
        addGradient()
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = contentView.bounds
        posterImageView.layer.addSublayer(gradientLayer)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 42),
            bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -42),
            bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            playButton.heightAnchor.constraint(equalToConstant: 30),
            playButton.widthAnchor.constraint(equalToConstant: 87)
        ])
    }
}

#Preview {
    HomeHeroCell()
}
