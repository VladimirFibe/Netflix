import Foundation

struct BrowseRow: Hashable {
    var index: Int
    var title: String?
    var items: [BrowseItem]
}
