import Foundation

struct Constant {
    static let API_Key = "d05573814638e3e0806fd4c425fe676a"
    static let baseURL = "https://api.themoviedb.org"
}

final class APICaller {
    static let shared = APICaller()
    private init() {}
    
    func getTrendingMovies(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/all/day?api_key=\(Constant.API_Key)")
        else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
