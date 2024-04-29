import Foundation

protocol HomeUseCaseProtocol {
    func execute() async throws -> HomeData
}

final class HomeUseCase: HomeUseCaseProtocol {
    
    private let apiService: HomeServiceProtocol
    
    init(apiService: HomeServiceProtocol) {
        self.apiService = apiService
    }
    
    func execute() async throws -> HomeData {
        var movies = try await apiService.getPopular()
        var hero: Movie? = nil
        if !movies.isEmpty { hero = movies.removeFirst() }
        let trendingMovies = try await apiService.getTrendingMovies()
        let trendingTV = try await apiService.getTrendingTV()
        let persons = try await apiService.getTrendingPerson()
        let homeData = HomeData(hero: hero, movies: movies, trendingMovies: trendingMovies, trendingTVs: trendingTV, persons: persons)
        return homeData
    }
}
