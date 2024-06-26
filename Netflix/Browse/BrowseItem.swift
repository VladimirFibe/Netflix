import Foundation

enum BrowseItem: Hashable {
    case hero(Title)
    case movies(Title)
    case tv(Title)
    case popular(Title)
    case upcoming(Title)
    case top(Title)
}
