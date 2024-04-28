import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

struct Movie: Codable, Hashable {
    let id: Int
    let overview: String?
    let posterPath: String
    let releaseDate: String?
    let title: String?
    var posterUrl: String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
}
