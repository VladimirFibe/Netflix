import Foundation

struct PersonResponse: Codable {
    let page: Int
    let results: [Person]
    let totalPages, totalResults: Int
}

struct Person: Codable, Hashable {
    let id: Int
    let name: String
    let profilePath: String
    let knownFor: [Movie]
    var profileUrl: String {
        "https://image.tmdb.org/t/p/w500\(profilePath)"
    }
}
