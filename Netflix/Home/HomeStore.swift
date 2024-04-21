import Foundation

enum HomeEvent {
    case didLoad(String)
}

enum HomeAction {
    case fetch
}

final class HomeStore: Store<HomeEvent, HomeAction> {
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
        sendEvent(.didLoad("Title"))
    }
}
