import UIKit

protocol AppFontProtocol {
    var rawValue: String { get }
}

extension AppFontProtocol {
    var s16: UIFont { apply(size: 16) }
}

extension AppFontProtocol {
    private func apply(size value: CGFloat) -> UIFont {
        UIFont.init(name: rawValue, size: value) ?? .systemFont(ofSize: value)
    }
}

enum AppFont: String, AppFontProtocol {
    case regular = "NetflixSans-Regular"
    case medium = "NetflixSans-Medium"
    case light = "NetflixSans-Light"
    case bold = "NetflixSans-Bold"
    
    static func printFonts() {
        for family in UIFont.familyNames.sorted() {
          let names = UIFont.fontNames(forFamilyName: family)
          print(family, names)
        }
    }
}
