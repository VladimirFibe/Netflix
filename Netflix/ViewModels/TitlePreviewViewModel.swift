import Foundation

struct TitlePreviewViewModel {
    let title: String
    let overview: String
    let youtube: String
    
    init(title: Title, video: VideoElement) {
        self.title = (title.original_title ?? title.original_name) ?? "no name"
        overview = title.overview ?? "no overview"
        youtube = "https://www.youtube.com/embed/\(video.id.videoId)"
    }
    
    init(item: TitleItem, video: VideoElement) {
        self.title = (item.original_name ?? item.original_title) ?? "no name"
        overview = item.overview ?? "no overview"
        youtube = "https://www.youtube.com/embed/\(video.id.videoId)"
    }
}
