
import UIKit

class Tendi_UserViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var user_header: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var user_follower_label: UILabel!
    @IBOutlet weak var user_following_label: UILabel!
    @IBOutlet weak var user_bio_label: UILabel!
    @IBOutlet weak var user_follow_button: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var centerView: UIView!

    var user: TendiLocalUser?

    private let dataStore = TendiLocalDataStore.shared
    private var userPostItems: [TendiUserPostItem] {
        guard let user = user else { return [] }
        return dataStore.postItems(for: user)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .white
        let right_item = UIBarButtonItem(image: UIImage(named: "tendi_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigationRightItemClick))
        navigationItem.rightBarButtonItem = right_item

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 148, height: 208)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "Tendi_UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")
        configureMutualFollowPrompt()
        configureUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        configureUser()
    }

    // 更多
    @objc func navigationRightItemClick() {
        ChooseMoeView.show(from: self, targetUser: user) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }

    @IBAction func tendi_followStatusChatClick(_ sender: UIButton) {
        if sender.tag == 985 { // 关注
            guard let user = user else { return }
            let followState = dataStore.toggleFollow(for: user)
            applyFollowState(followState)
        }else { // 聊天
            guard let user = user else { return }
            guard dataStore.isMutuallyFollowing(user) else {
                showMutualFollowPrompt()
                return
            }

            let chatViewController = Tendi_ChatViewController()
            chatViewController.user = user
            chatViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(chatViewController, animated: true)
        }
    }

    private func configureUser() {
        guard let user = user else { return }

        user_header.image = UIImage(named: user.avatarImageName) ?? UIImage(named: "tendi_avatar")
        user_header.layer.cornerRadius = 36
        user_header.layer.masksToBounds = true
        user_name.text = "@\(user.nickname)"
        user_following_label.text = "\(user.followingCount) Following"
        user_bio_label.text = user.bio.isEmpty ? "Tennis, daily moments, and a little sunshine." : user.bio
        applyFollowState(dataStore.followState(for: user))
        collectionView.reloadData()
    }

    private func applyFollowState(_ state: TendiUserFollowState) {
        user_follower_label.text = "\(state.followerCount) Followers"
        user_follow_button.isHidden = state.canFollow == false
        user_follow_button.isEnabled = state.canFollow

        let followImageName = state.isFollowed ? "user_home_followed" : "user_home_follow"
        user_follow_button.setImage(UIImage(named: followImageName), for: .normal)
    }

    private func configureMutualFollowPrompt() {
        centerView.removeFromSuperview()
        centerView.alpha = 1
        addPromptDismissTargets(in: centerView)
    }

    private func showMutualFollowPrompt() {
        guard centerView.superview == nil else { return }

        guard let containerView = view.window ?? view else { return }
        centerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(centerView)

        NSLayoutConstraint.activate([
            centerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            centerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            centerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            centerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        centerView.alpha = 0
        UIView.animate(withDuration: 0.18) {
            self.centerView.alpha = 1
        }
    }

    private func addPromptDismissTargets(in view: UIView) {
        if let button = view as? UIButton {
            button.addTarget(self, action: #selector(dismissMutualFollowPrompt), for: .touchUpInside)
        }

        view.subviews.forEach { subview in
            addPromptDismissTargets(in: subview)
        }
    }

    @objc private func dismissMutualFollowPrompt() {
        UIView.animate(withDuration: 0.16, animations: {
            self.centerView.alpha = 0
        }, completion: { _ in
            self.centerView.removeFromSuperview()
            self.centerView.alpha = 1
        })
    }

}

extension Tendi_UserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPostItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! Tendi_UserCollectionViewCell
        let item = userPostItems[indexPath.item]
        cell.backgroundColor = .clear
        cell.configure(with: item, likeState: dataStore.likeState(for: item))
        cell.likeButtonClickHandler = { [weak self, weak cell] in
            guard let self else { return }
            let likeState = self.dataStore.toggleLike(for: item)
            cell?.applyLikeState(likeState)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = userPostItems[indexPath.item]

        switch item {
        case .video(let videoItem):
            let playViewController = Tendi_PlayViewController()
            playViewController.videoItem = videoItem
            playViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(playViewController, animated: true)
        case .image(let imageItem):
            let detailsViewController = Tendi_DetailsViewController()
            detailsViewController.postItem = imageItem
            detailsViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
