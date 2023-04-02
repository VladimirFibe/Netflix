import UIKit

class UpcomingViewController: UIViewController {

    var titles: [Title] = []
    lazy var tableView = UITableView().apply {
        $0.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
        title = "Upcoming"
        view.addSubview(tableView)
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovies {[weak self] result in
            switch result {
            case .success(let titles): DispatchQueue.main.async {
                self?.titles = titles
                self?.tableView.reloadData()
            }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
        else { return UITableViewCell()}
        cell.configure(with: TitleViewModel(title: titles[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.item]
        guard let name = title.original_name ?? title.original_title else { return }
        APICaller.shared.getMovie(with: name) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let video):
                    let controller = TitlePreviewViewController()
                    let title = self.titles[indexPath.row]
                    controller.configure(with: TitlePreviewViewModel(title: title, video: video))
                    self.navigationController?.pushViewController(controller, animated: true)
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}
