import Foundation

enum APIRoute {
    case getTrendingMovies
    case getTrendingTvs
    case getUpcomingMovies
    case getPopular
    case getTopRated
    case search(String)
    
    var link: String {
        switch self {
        case .getTrendingMovies:
            return "\(Constants.baseURL)/3/trending/movie/day"
        case .getTrendingTvs:
            return "\(Constants.baseURL)/3/trending/tv/day"
        case .getUpcomingMovies:
            return "\(Constants.baseURL)/3/movie/upcoming"
        case .getPopular:
            return "\(Constants.baseURL)/3/movie/popular"
        case .getTopRated:
            return "\(Constants.baseURL)/3/movie/top_rated"
        case .search(_):
            return "\(Constants.baseURL)/3/search/movie"
        }
    }
    
    var url: URL? {
        guard var components = URLComponents(string: link) else { return nil}
        
        switch self {
        case .getUpcomingMovies, .getPopular, .getTopRated:
            components.queryItems = [URLQueryItem(name: "api_key", value: Constants.API_KEY), 
                                     URLQueryItem(name: "language", value: "en-US"),
                                     URLQueryItem(name: "page", value: "1")]
        case .search(let query):
            components.queryItems = [URLQueryItem(name: "api_key", value: Constants.API_KEY),
                                     URLQueryItem(name: "query", value: query)]
        default:
            components.queryItems = [URLQueryItem(name: "api_key", value: Constants.API_KEY)]
        }
        print(components.url ?? "no url")
        return components.url
    }
    
    var request: URLRequest? {
        guard let url else { return nil }
        return URLRequest(url: url)
    }
}
