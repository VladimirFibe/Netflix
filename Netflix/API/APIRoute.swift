import Foundation

enum APIRoute {
    enum MediaType: String {
        case tv
        case movie
        case person
        case all
    }
    
    enum TimeWindow: String {
        case day
        case week
    }
    
    enum Language: String {
        case enEn = "en-EN"
        case ruRu = "ru-RU"
    }
    
    enum Region: String {
        case ru = "RU"
        case en = "EN"
    }
    enum MovieType: String {
        case popular
        case upcoming
        case top = "top_rated"
        case plaing = "now_playing"
    }
    
    case getPopular(type: MovieType, language: Language, page: Int, region: Region?)
    case getTrending(mediaType: MediaType, time: TimeWindow, language: Language)
    
    var baseUrl: String {
        "https://api.themoviedb.org/"
    }
    
    var fullUrl: String {
        switch self {
        case .getPopular(let type, _, _, _): return "\(baseUrl)3/movie/\(type)"
        case .getTrending(let mediaType, let time, _):
            return "\(baseUrl)3/trending/\(mediaType.rawValue)/\(time.rawValue)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getPopular(_, let lang, let page, let region):
            var items = [URLQueryItem(name: "language", value: lang.rawValue),
                         URLQueryItem(name: "page", value: "\(page)")]
            if let region { items.append(URLQueryItem(name: "region", value: region.rawValue))}
            return items
        case .getTrending(_, _, let lang):
            return [URLQueryItem(name: "language", value: lang.rawValue)]
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
        print("DEBUG:", fullUrl)
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
