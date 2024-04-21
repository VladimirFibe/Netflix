import Foundation

final class BrowseViewModel {
    var browse: Browse? {
        didSet {
            rows = [
                BrowseRow(
                    index: 0,
                    title: nil,
                    items: (browse?.hero ?? []).map { .hero($0)}
                ),
                BrowseRow(
                    index: 1,
                    title: "Trending Moviews",
                    items: (browse?.movies ?? []).map { .movies($0) }
                ),
                BrowseRow(
                    index: 2,
                    title: "Trending TV",
                    items: (browse?.tv ?? []).map { .tv($0) }
                ),
                BrowseRow(
                    index: 3,
                    title: "Popular",
                    items: (browse?.popular ?? []).map { .popular($0) }
                ),
                BrowseRow(
                    index: 4,
                    title: "Upcoming Movies",
                    items: (browse?.upcoming ?? []).map { .upcoming($0) }
                ),
                BrowseRow(
                    index: 5,
                    title: "Top rated",
                    items: (browse?.top ?? []).map { .top($0) }
                )
            ]
        }
    }
    
    var rows: [BrowseRow] = []
}
