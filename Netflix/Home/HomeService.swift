import Foundation

protocol HomeServiceProtocol {
    func getTrendingMovies() async throws -> [Movie]
    func getTrendingTvs() async throws -> [Movie]
    func getPopularMovies() async throws -> [Movie]
    func getTopRatedMovies() async throws -> [Movie]
    func getUpcomingMovies() async throws -> [Movie]
}

final class HomeService: HomeServiceProtocol {
    func getUpcomingMovies() async throws -> [Movie] {
        try await getMovies("Upcoming")
    }
    
    func getTrendingTvs() async throws -> [Movie] {
        try await getMovies("TV")
    }
    
    func getPopularMovies() async throws -> [Movie] {
        try await getMovies("Popular")
    }
    
    func getTopRatedMovies() async throws -> [Movie] {
        try await getMovies("Top")
    }
    
    func getTrendingMovies() async throws -> [Movie] {
        try await getMovies("Movies")
    }
    func getMovies(_ name: String) async throws -> [Movie] {
        Bundle.main.decode([Movie].self, frome: "\(name).json")
    }
}
