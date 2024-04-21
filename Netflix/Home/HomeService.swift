import Foundation

protocol HomeServiceProtocol {
    func getTitle() async throws -> String
}

final class HomeService: HomeServiceProtocol {
    func getTitle() async throws -> String {
        "Title"
    }
}
