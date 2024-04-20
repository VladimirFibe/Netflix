import Foundation

final class BrowseViewModel {
    var browse: Browse? {
        didSet {
            rows = [
                BrowseRow(
                    index: 0,
                    title: "Movies",
                    items: (browse?.movies ?? []).map { .movies($0) }
                ),
                BrowseRow(
                    index: 1,
                    title: "TV",
                    items: (browse?.tv ?? []).map { .tv($0) }
                ),
                BrowseRow(
                    index: 2,
                    title: "Popular",
                    items: (browse?.popular ?? []).map { .popular($0) }
                ),
                BrowseRow(
                    index: 3,
                    title: "upcoming",
                    items: (browse?.upcoming ?? []).map { .upcoming($0) }
                ),
                BrowseRow(
                    index: 4,
                    title: "top",
                    items: (browse?.top ?? []).map { .top($0) }
                )
            ]
        }
    }
    
    var rows: [BrowseRow] = []
}
