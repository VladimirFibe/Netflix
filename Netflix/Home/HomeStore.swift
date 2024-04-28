import Foundation

enum HomeEvent {
    case didLoad(HomeData)
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
        var movies = Bundle.main.decode([Movie].self, from: "Movies.json")
        let hero = movies.removeFirst()
        let homeData = HomeData(hero: hero, movies: movies)
        sendEvent(.didLoad(homeData))
    }
}
