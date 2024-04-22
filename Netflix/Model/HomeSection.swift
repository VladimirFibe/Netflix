import Foundation

struct HomeSection: Hashable {
    let id = UUID().uuidString
    let title: String?
    let movies: [Movie]
}
