import Foundation

enum HomeItem: Hashable {
    case hero(Movie)
    case movie(Movie)
    case trendingMovie(Movie)
    case trendingTV(Movie)
    case person(Person)
}
