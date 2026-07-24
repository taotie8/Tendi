
import UIKit

class Tendi_MineViewController: BaseViewController {

    @IBOutlet weak var mine_h: UIImageView!
    @IBOutlet weak var mine_n: UILabel!
    @IBOutlet weak var mine_follower: UIButton!
    @IBOutlet weak var mine_following: UIButton!
    @IBOutlet weak var mine_dallar_l: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let dataStore = TendiLocalDataStore.shared
    private lazy var postPlaceholderView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear

        let imageView = UIImageView(image: UIImage(named: "tendi_yet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 26),
            imageView.widthAnchor.constraint(equalToConstant: 153),
            imageView.heightAnchor.constraint(equalToConstant: 131)
        ])

        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let right_item = UIBarButtonItem(image: UIImage(named: "tendi_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigationRightItemClick))
        navigationItem.rightBarButtonItem = right_item
        mine_h.layer.cornerRadius = 36
        mine_h.layer.masksToBounds = true
        configurePostPlaceholder()
        configureProfile()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(coinBalanceDidChange),
            name: .tendiCoinBalanceDidChange,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(currentUserProfileDidChange),
            name: .tendiCurrentUserProfileDidChange,
            object: nil
        )
    }

    @MainActor deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureProfile()
    }
    
    // 更多
    @objc func navigationRightItemClick() {
        let vc = Tendi_SettingViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tendi_dallarsClick(_ sender: Any) {
        let vc = Tendi_DallarViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tendi_followingAndfollowerClick(_ sender: UIButton) {
        let vc = Tendi_PersonViewController()
        if sender.tag == 985 {
            vc.mode = .followers
        }else {
            vc.mode = .following
        }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    private func configureProfile() {
        if let currentUser = dataStore.currentUserProfile {
            mine_h.image = UIImage(named: currentUser.avatarImageName) ?? UIImage(named: "tendi_avatar")
            mine_n.text = "@\(currentUser.nickname)"
        }

        mine_follower.setTitle("\(dataStore.currentFollowerUsers.count) Followers", for: .normal)
        mine_following.setTitle("\(dataStore.currentFollowingUsers.count) Following", for: .normal)
        mine_dallar_l.text = "\(dataStore.currentCoinBalance)"
    }

    private func configurePostPlaceholder() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.backgroundView = postPlaceholderView
    }

    @objc private func coinBalanceDidChange() {
        configureProfile()
    }

    @objc private func currentUserProfileDidChange() {
        configureProfile()
    }

}
