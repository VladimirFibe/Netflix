import UIKit

final class HomeSectionHeader: BaseCollectionReusableView {
    static let identifier = "HomeSectionHeader"
    private let label: UILabel = {
        $0.text = "Title"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.textColor = .label
        $0.font = AppFont.medium.s16
        return $0
    }(UILabel())
    
    func configure(with text: String?) {
        label.text = text
    }
}

extension HomeSectionHeader {
    override func setupViews() {
        addSubview(label)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 1)
        ])
    }
}
