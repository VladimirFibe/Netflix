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
