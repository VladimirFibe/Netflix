//import Foundation
//
//enum HomeEvent {
//    case didLoad([HomeSection])
//}
//
//enum HomeAction {
//    case fetch
//}
//
//final class HomeStore: Store<HomeEvent, HomeAction> {
//    override func handleActions(action: HomeAction) {
//        switch action {
//        case .fetch:
//            statefulCall {
//                weak var wSelf = self
//                try await wSelf?.fetch()
//            }
//        }
//    }
//    
//    private func fetch() async throws {
//        let movies = Bundle.main.decode([Movie].self, from: "Movies.json")
//        let sections = [
//            HomeSection(title: nil, movies: Array(movies[0...0])),
//            HomeSection(title: "Trending Moviews", movies: Array(movies[1...4])),
//            HomeSection(title: "Trending TV", movies: Array(movies[5...8])),
//            HomeSection(title: "Popular", movies: Array(movies[9...11])),
//            HomeSection(title: "Upcoming Movies", movies: Array(movies[12...14])),
//            HomeSection(title: "Top rated", movies: Array(movies[15...19]))
//        ]
//        sendEvent(.didLoad(sections))
//    }
//}
