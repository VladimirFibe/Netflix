import UIKit

final class BrowseHeroCell: BaseCollectionViewCell, SelfConfiguringCell {
    static var identifier = "BrowseHeroCell"
    
    private let downloadButton: UIButton = {
        $0.setTitle("Download", for: [])
        $0.tintColor = .label
        $0.layer.borderColor = UIColor.label.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    
    private let playButton: UIButton = {
        $0.setTitle("Play", for: [])
        $0.tintColor = .label
        $0.layer.borderColor = UIColor.label.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    
    private let heroImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(image: .hero))
    
    func configure(with title: Title) {
        heroImageView.kf.setImage(with: title.url)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        heroImageView.layer.addSublayer(gradientLayer)
    }
}
// MARK: - Actions
extension BrowseHeroCell {
    @objc private func downloadTapped() {
        print(#function)
    }
    
    @objc private func playTapped() {
        print(#function)
    }
}
// MARK: - Setup Views
extension BrowseHeroCell {
    override func setupViews() {
        [heroImageView, playButton, downloadButton].forEach { contentView.addSubview($0)}
        playButton.addTarget(self, action: #selector(playTapped), for: .primaryActionTriggered)
        downloadButton.addTarget(self, action: #selector(downloadTapped), for: .primaryActionTriggered)
        addGradient()
    }
    
    override func setupConstraints() {
        let verticalPadding = -50.0
        let horizontalPadding = 70.0
        let width = 120.0
        NSLayoutConstraint.activate([
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: verticalPadding),
            downloadButton.widthAnchor.constraint(equalToConstant: width),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: verticalPadding),
            playButton.widthAnchor.constraint(equalTo: downloadButton.widthAnchor)
        ])
    }
}
