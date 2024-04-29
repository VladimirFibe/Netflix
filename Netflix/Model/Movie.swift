import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

struct Movie: Codable, Hashable {
    let id: Int
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let title: String?
    let originalTitle: String?
    var posterUrl: String {
        "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
    var backdropUrl: String {
        "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")"
    }
    var titleString: String {
        title ?? originalTitle ?? "No name"
    }
}
