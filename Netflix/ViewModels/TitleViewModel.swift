import Foundation

struct TitleViewModel {
    let id: Int
    let mediaType: String
    let name: String
    let poster: String
    let overview: String
    init(title: Title) {
        id = title.id
        mediaType = title.media_type ?? ""
        name = (title.original_title ?? title.original_name) ?? ""
        poster = title.poster_path ?? ""
        overview = title.overview ?? ""
    }
    
    init(item: TitleItem) {
        id = Int(item.id)
        mediaType = item.media_type ?? ""
        name = (item.original_title ?? item.original_name) ?? ""
        poster = item.poster_path ?? ""
        overview = item.overview ?? ""
    }
}
