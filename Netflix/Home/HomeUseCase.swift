import Foundation

protocol HomeUseCaseProtocol {
    func execute() async throws -> [HomeSection]
}

final class HomeUseCase: HomeUseCaseProtocol {
    private let apiService: HomeServiceProtocol
    init(apiService: HomeServiceProtocol) {
        self.apiService = apiService
    }
    func execute() async throws -> [HomeSection] {
        let movies = try await apiService.getTrendingMovies()
        var hero: [Movie] = []
        if let title = movies.randomElement() {
            hero.append(title)
        }
        let tv = try await apiService.getTrendingTvs()
        let popular = try await apiService.getPopularMovies()
        let upcoming = try await apiService.getUpcomingMovies()
        let top = try await apiService.getTopRatedMovies()
        return [
            HomeSection(id: 0, title: nil, movies: hero),
            HomeSection(id: 1, title: "Trending Moviews", movies: movies),
            HomeSection(id: 2, title: "Trending TV", movies: tv),
            HomeSection(id: 3, title: "Popular", movies: popular),
            HomeSection(id: 4, title: "Upcoming Movies", movies: upcoming),
            HomeSection(id: 5, title: "Top rated", movies: top)
        ]
    }
}
