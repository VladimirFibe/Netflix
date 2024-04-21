import UIKit

final class BrowseHeroCell: BaseCollectionViewCell {
    static let idetifier = "BrowseHeroCell"
    
    private let downloadButton: UIButton = {
        $0.setTitle("Download", for: [])
        $0.tintColor = .black
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    
    private let playButton: UIButton = {
        $0.setTitle("Play", for: [])
        $0.tintColor = .black
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    
    private let heroImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(image: UIImage(named: "heroImage")))
    
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

extension BrowseHeroCell {
    override func setupViews() {
        [heroImageView, playButton, downloadButton].forEach { contentView.addSubview($0)}
        addGradient()
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
