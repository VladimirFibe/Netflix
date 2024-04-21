import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable, Hashable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    
    var url: URL? {
        if let poster = poster_path {
            return URL(string: "https://image.tmdb.org/t/p/w500/\(poster)")
        } else {
            return nil
        }
    }
}
