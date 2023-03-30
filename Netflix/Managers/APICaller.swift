import Foundation

struct Constant {
    static let API_Key = "d05573814638e3e0806fd4c425fe676a"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case fail
}
final class APICaller {
    static let shared = APICaller()
    private init() {}
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        guard let url = URL(string: "\(Constant.baseURL)/3/trending/all/day?api_key=\(Constant.API_Key)")

        guard let url = URL(string: "\(Constant.baseURL)/3/trending/movie/day?api_key=\(Constant.API_Key)")
        else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.fail))
                return
            }
//            print(String(data: data, encoding: .utf8))
            do {
                let response = try JSONDecoder().decode(TrendingMoviewsResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
