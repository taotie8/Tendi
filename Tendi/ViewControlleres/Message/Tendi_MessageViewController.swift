
import UIKit

class Tendi_MessageViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    private let dataStore = TendiLocalDataStore.shared
    private var chatPreviewItems: [TendiChatPreviewItem] = []
    private lazy var emptyStateView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear

        let imageView = UIImageView(image: UIImage(named: "tendi_yet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 153),
            imageView.heightAnchor.constraint(equalToConstant: 131)
        ])

        return containerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "Tendi_MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 102
        tableView.separatorStyle = .none
        tableView.backgroundView = emptyStateView
        reloadChatPreviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        reloadChatPreviews()
    }

    private func reloadChatPreviews() {
        chatPreviewItems = dataStore.chatPreviewItems
        emptyStateView.isHidden = chatPreviewItems.isEmpty == false
        tableView.reloadData()
    }
}

extension Tendi_MessageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatPreviewItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Tendi_MessageTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(with: chatPreviewItems[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Tendi_ChatViewController()
        vc.user = chatPreviewItems[indexPath.row].user
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
