import Foundation

protocol HomeServiceProtocol {
    func getPopular() async throws -> [Movie]
}

final class HomeService: HomeServiceProtocol {
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
    func getPopular() async throws -> [Movie] {
        let response: MovieResponse = try await request(.getPopular(language: "ru-RU", page: 1, region: "RU"))
        return response.results
    }
}
