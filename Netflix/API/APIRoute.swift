import Foundation

enum APIRoute {
    
    case getPopular(language: String, page: Int, region: String?)
    
    var baseUrl: String {
        "https://api.themoviedb.org/"
    }
    
    var fullUrl: String {
        switch self {
        case .getPopular: return "\(baseUrl)3/movie/popular"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getPopular(let lang, let page, let region):
            var items = [URLQueryItem(name: "language", value: lang),
                         URLQueryItem(name: "page", value: "\(page)")]
            if let region { items.append(URLQueryItem(name: "region", value: region))}
            return items
        }
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var token: String {
        (Bundle.main.object(forInfoDictionaryKey: "Token") as? String) ?? ""
    }
    
    var allHTTPHeaderFields: [String: String] {
        ["accept": "application/json", "Authorization": token]
    }
    
    var request: URLRequest? {
        guard let url = URL(string: fullUrl),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else { return nil }
        components.queryItems = queryItems

        var request = URLRequest(url: components.url ?? url)
        request.httpMethod = httpMethod
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = allHTTPHeaderFields
        return request
    }
}
