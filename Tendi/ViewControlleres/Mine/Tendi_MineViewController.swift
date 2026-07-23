
import UIKit

class Tendi_MineViewController: BaseViewController {

    @IBOutlet weak var mine_h: UIImageView!
    @IBOutlet weak var mine_n: UILabel!
    @IBOutlet weak var mine_follower: UIButton!
    @IBOutlet weak var mine_following: UIButton!
    @IBOutlet weak var mine_dallar_l: UILabel!

    private let dataStore = TendiLocalDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let right_item = UIBarButtonItem(image: UIImage(named: "tendi_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigationRightItemClick))
        navigationItem.rightBarButtonItem = right_item
        mine_h.layer.cornerRadius = 36
        mine_h.layer.masksToBounds = true
        configureProfile()
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
    }

}
