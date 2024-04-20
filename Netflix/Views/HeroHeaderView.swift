import UIKit

class HeroHeaderView: UIView {
    private let downloadButton = UIButton(type: .system).apply {
        $0.setTitle("Download", for: .normal)
        $0.tintColor = .white
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let playButton = UIButton(type: .system).apply {
        $0.setTitle("Play", for: .normal)
        $0.tintColor = .white
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let heroImageView = UIImageView(image: UIImage(named: "heroImage")).apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        layer.addSublayer(gradientLayer)
    }
    
    private func applyConstraints() {
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    public func configure(with model: TitleViewModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.poster)")
        heroImageView.kf.setImage(with: url)
    }
}
