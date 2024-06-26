import Foundation

protocol FetchBrowseSectionsUseCaseProtocol {
    func execute() async throws -> Browse
}

final class FetchBrowseSectionsUseCase: FetchBrowseSectionsUseCaseProtocol {
    private let apiService: BrowseServiceProtocol
    
    init(apiService: BrowseServiceProtocol) {
        self.apiService = apiService
    }
    
    func execute() async throws -> Browse {
        
        let movies = try await apiService.getMovies()
        let tv = try await apiService.getTV()
        let popular = try await apiService.getPopular()
        let upcoming = try await apiService.getUpcoming()
        let top = try await apiService.getTop()
        let hero: [Title]
        if let title = movies.randomElement() {
            hero = [title]
        } else {
            hero = []
        }
        return Browse(hero: hero, movies: movies, tv: tv, popular: popular, upcoming: upcoming, top: top)
    }
}
