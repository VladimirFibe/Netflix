import Foundation

protocol HomeUseCaseProtocol {
    func execute() async throws -> String
}

final class HomeUseCase: HomeUseCaseProtocol {
    private let apiService: HomeServiceProtocol
    init(apiService: HomeServiceProtocol) {
        self.apiService = apiService
    }
    func execute() async throws -> String {
        let title = try await apiService.getTitle()
        return title
    }
}
