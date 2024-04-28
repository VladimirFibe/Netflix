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
        let homeData = HomeData(hero: hero, movies: movies)
        return homeData
    }
}
