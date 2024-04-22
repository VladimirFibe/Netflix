import Foundation

enum HomeEvent {
    case didLoad([HomeSection])
}

enum HomeAction {
    case fetch
}

final class HomeStore: Store<HomeEvent, HomeAction> {
    override func handleActions(action: HomeAction) {
        switch action {
        case .fetch:
            statefulCall {
                weak var wSelf = self
                try await wSelf?.fetch()
            }
        }
    }
    
    private func fetch() async throws {
        let movies = Bundle.main.decode([Movie].self, from: "Movies.json")
        var hero: [Movie] = []
        if let movie = movies.randomElement() {
            hero.append(movie)
        }
        let sections = [
            HomeSection(title: nil, movies: hero),
            HomeSection(title: "Trending Moviews", movies: movies),
            HomeSection(title: "Trending TV", movies: movies),
            HomeSection(title: "Popular", movies: movies),
            HomeSection(title: "Upcoming Movies", movies: movies),
            HomeSection(title: "Top rated", movies: movies)
        ]
        sendEvent(.didLoad(sections))
    }
}
