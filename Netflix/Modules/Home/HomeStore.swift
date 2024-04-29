import Foundation

enum HomeEvent {
    case didLoad(HomeData)
}

enum HomeAction {
    case fetch
}

final class HomeStore: Store<HomeEvent, HomeAction> {
    private let useCase: HomeUseCaseProtocol
    
    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }
    
    override func handleActions(action: HomeAction) {
        switch action {
        case .fetch:
            statefulCall {
                weak var wSelf = self
                try await wSelf?.fetch()
            }
        }
    }
    
    private func fetch() async throws {
        let homeData = try await useCase.execute()
        sendEvent(.didLoad(homeData))
    }
}
