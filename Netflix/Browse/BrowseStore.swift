import Foundation

enum BrowseEvent {
    case didLoadSections(Browse)
}

enum BrowseAction {
    case fetch
}

final class BrowseStore: Store<BrowseEvent, BrowseAction> {
    private let useCase: FetchBrowseSectionsUseCase
    
    init(useCase: FetchBrowseSectionsUseCase) {
        self.useCase = useCase
    }

    override func handleActions(action: BrowseAction) {
        switch action {
        case .fetch:
            statefulCall {
                weak var wSelf = self
                try await wSelf?.fetch()
            }
        }
    }
    
    private func fetch() async throws {
        let browse = try await useCase.execute()
        sendEvent(.didLoadSections(browse))
    }

}
