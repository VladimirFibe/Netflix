import UIKit

class HomeViewController: UIViewController {
    private let store = HomeStore()
    var bag = Bag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        store.sendAction(.fetch)
        setupObservers()
    }
    
    private func setupObservers() {
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
    
    private func printTitle(_ title: String) {
        print(title)
    }
}
