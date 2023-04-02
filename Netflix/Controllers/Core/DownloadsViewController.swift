import UIKit

class DownloadsViewController: UIViewController {

    private var items: [TitleItem] = []
    
    private lazy var tableView = UITableView().apply {
        $0.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Downloads"
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self?.items = items
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        let item = items[indexPath.row]
        cell.configure(with: TitleViewModel(item: item))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteTitleWith(model: item) {[weak self] result in
                switch result {
                case .success():
                    self?.items.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        guard let titleName = item.original_title ?? item.original_name else {
            return
        }
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let video):
                DispatchQueue.main.async {
                    let controller = TitlePreviewViewController()
                    controller.configure(with: TitlePreviewViewModel(item: item, video: video))
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
