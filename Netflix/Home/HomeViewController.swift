import UIKit

class HomeViewController: BaseViewController {
    private let store: HomeStore
    init(store: HomeStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func printTitle(_ title: String) {
        print(title)
    }
}
// MARK: - Setup Views
extension HomeViewController {
    override func setupViews() {
        store.sendAction(.fetch)
    }
    override func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .didLoad(title):
                    self.printTitle(title)
                }
            }.store(in: &bag)
    }
}
