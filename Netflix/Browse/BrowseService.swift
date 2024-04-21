import Foundation

protocol BrowseServiceProtocol {
    func getMovies() async throws -> [Title]
    func getTV() async throws -> [Title]
    func getPopular() async throws -> [Title]
    func getUpcoming() async throws -> [Title]
    func getTop() async throws -> [Title]
}

extension APICaller: BrowseServiceProtocol {
    func getMovies() async throws -> [Title] {
        let result: TrendingTitleResponse = try await request(.getTrendingMovies)
        return result.results
    }
    
    func getTV() async throws -> [Title] {
        let result: TrendingTitleResponse = try await request(.getTrendingTvs)
        return result.results
    }
    
    func getPopular() async throws -> [Title] {
        let result: TrendingTitleResponse = try await request(.getPopular)
        return result.results
    }
    
    func getUpcoming() async throws -> [Title] {
        let result: TrendingTitleResponse = try await request(.getUpcomingMovies)
        return result.results
    }
    
    func getTop() async throws -> [Title] {
        let result: TrendingTitleResponse = try await request(.search("Queen"))
        return result.results
    }
}
