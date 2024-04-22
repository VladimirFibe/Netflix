import Foundation

struct Movie: Codable, Hashable {
    let id: Int
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    var posterUrl: String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
}
