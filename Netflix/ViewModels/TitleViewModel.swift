import Foundation

struct TitleViewModel {
    let id: Int
    let mediaType: String
    let name: String
    let title: String
    let poster: String
    let overview: String
    init(title: Title) {
        id = title.id
        mediaType = title.media_type ?? ""
        name = title.original_name ?? ""
        self.title = title.original_title ?? ""
        poster = title.poster_path ?? ""
        overview = title.overview ?? ""
    }
}
