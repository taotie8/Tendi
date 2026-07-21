
import UIKit

class Tendi_MessageViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    private let dataStore = TendiLocalDataStore.shared
    private var chatPreviewItems: [TendiChatPreviewItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "Tendi_MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 102
        tableView.separatorStyle = .none
        reloadChatPreviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        reloadChatPreviews()
    }

    private func reloadChatPreviews() {
        chatPreviewItems = dataStore.chatPreviewItems
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
