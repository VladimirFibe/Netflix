import UIKit

class HomeViewController: BaseViewController {
    var sections: [HomeSection] = []
    private let store: HomeStore
    init(store: HomeStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reloadData() {
        print(sections.count)
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
                case let .didLoad(sections):
                    self.sections = sections
                    reloadData()
                }
            }.store(in: &bag)
    }
}
