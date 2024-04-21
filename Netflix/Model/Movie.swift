import Foundation

struct Movie: Codable, Hashable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    
    var url: URL? {
        if let poster = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500/\(poster)")
        } else {
            return nil
        }
    }
}
