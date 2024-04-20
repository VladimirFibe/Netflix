import Combine
import SwiftUI

typealias Bag = Set<AnyCancellable>
typealias Callback = () -> Void

class Store<Event, Action> {
    private(set) var events = PassthroughSubject<Event, Never>()
    private(set) var actions = PassthroughSubject<Action, Never>()

    var bag = Bag()

    init() {
        setupActionHandlers()
    }

    func sendAction(_ action: Action) {
        actions.send(action)
    }

    func sendEvent(_ event: Event) {
        events.send(event)
    }

    func setupActionHandlers() {
        actions.sink { [weak self] action in
            guard let self else { return }
            self.handleActions(action: action)
        }.store(in: &bag)
    }

    func handleActions(action: Action) {}

    func statefulCall(_ action: @MainActor @escaping () async throws -> ()) {
        Task { try await action() }
    }
}
