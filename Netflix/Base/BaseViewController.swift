import UIKit

class BaseViewController: UIViewController {
    var bag = Bag()
    deinit {
        print("\(String(describing: self)) dealloc" )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupObservers()
    }
}

@objc extension BaseViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
    }
    func setupConstraints() {}
    func setupObservers() {}
}
