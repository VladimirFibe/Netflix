import Foundation

protocol HomeServiceProtocol {
    func getPopular() async throws -> [Movie]
    func getTrendingMovies() async throws -> [Movie]
    func getTrendingTV() async throws -> [Movie]
    func getTrendingPerson() async throws -> [Person]
}

final class HomeService: HomeServiceProtocol {
    func getTrendingPerson() async throws -> [Person] {
        []
    }
    
    func getTrendingTV() async throws -> [Movie] {
        []
    }
    
    func getTrendingMovies() async throws -> [Movie] {
        []
    }
    
    static let shared = HomeService()
    private init() {}
    
    func getPopular() async throws -> [Movie] {
        try await getMovies("Movies")
    }
    
    
    func getMovies(_ name: String) async throws -> [Movie] {
        Bundle.main.decode([Movie].self, from: "\(name).json")
    }
}

extension APIClent: HomeServiceProtocol {
    func getTrendingPerson() async throws -> [Person] {
        let response: PersonResponse = try await request(.getTrending(mediaType: .person, time: .day, language: .ruRu))
        response.results.forEach { print("DEBUG: ", $0.profileUrl)}
        return response.results
    }
    
    func getTrendingTV() async throws -> [Movie] {
        let response: MovieResponse = try await request(.getTrending(mediaType: .tv, time: .day, language: .ruRu))
        return response.results
    }
    
    func getTrendingMovies() async throws -> [Movie] {
        let response: MovieResponse = try await request(.getTrending(mediaType: .movie, time: .day, language: .ruRu))
        return response.results
    }
    
    func getPopular() async throws -> [Movie] {
        let response: MovieResponse = try await request(.getPopular(type: .popular, language: .ruRu, page: 1, region: .ru))
        return response.results
    }
}
