import UIKit
import Kingfisher

class TitleTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    private let posterImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let titleLabel = UILabel().apply {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var playButton = UIButton(type: .system).apply {
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        $0.setImage(image, for: .normal)
        $0.tintColor = .label
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        layoutViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            
            playButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            playButton.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(with title: TitleViewModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(title.poster)")
        posterImageView.kf.setImage(with: url)
        titleLabel.text = title.name
    }
}
