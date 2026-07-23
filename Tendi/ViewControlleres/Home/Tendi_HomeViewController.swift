

import UIKit

class Tendi_HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var discover_button: UIButton!
    @IBOutlet weak var follow_button: UIButton!
    private let dataStore = TendiLocalDataStore.shared
    private var showingFollowVideos = false
    private var videoItems: [TendiHomeVideoItem] {
        showingFollowVideos ? dataStore.followedVideoItems : dataStore.videoItems
    }
    private var recommendationItems: [TendiHomeVideoItem] {
        Array(dataStore.videoItems.prefix(4))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 118, height: 148)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "Tendi_HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")

        tableView.register(UINib(nibName: "Tendi_HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    @IBAction func tap_discoverAndFollowClick(_ sender: UIButton) {
        discover_button.setImage(UIImage(named: "home_discover"), for: .normal)
        follow_button.setImage(UIImage(named: "home_follow"), for: .normal)
        if sender.tag == 321 {
            showingFollowVideos = false
            discover_button.setImage(UIImage(named: "home_discover_s"), for: .normal)
        }
        else {
            showingFollowVideos = true
            follow_button.setImage(UIImage(named: "home_follow_s"), for: .normal)
        }
        tableView.reloadData()
    }


}

extension Tendi_HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationItems.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! Tendi_HomeCollectionViewCell
        cell.backgroundColor = .clear
        if indexPath.item == 0 {
            cell.configureAsPostEntry()
        } else {
            cell.configure(with: recommendationItems[indexPath.item - 1])
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item > 0 {
            let playViewController = Tendi_PlayViewController()
            playViewController.videoItem = recommendationItems[indexPath.item - 1]
            playViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(playViewController, animated: true)
            return
        }

        let postViewController = Tendi_PostViewController()
        postViewController.publishMode = .video
        postViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

extension Tendi_HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Tendi_HomeTableViewCell
        let item = videoItems[indexPath.row]
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let likeState = dataStore.likeState(for: item)
        let followState = dataStore.followState(for: item)
        cell.configure(
            with: item,
            likeCount: likeState.count,
            isLiked: likeState.isLiked,
            commentCount: dataStore.commentCount(for: item),
            followState: followState
        )
        cell.moreButtonClickHandler = { [weak self] in
            self?.showChooseMoeView(for: item.user)
        }
        cell.likeButtonClickHandler = { [weak self, weak cell] in
            guard let self = self else { return }
            let likeState = self.dataStore.toggleLike(for: item)
            cell?.applyLikeState(count: likeState.count, isLiked: likeState.isLiked)
        }
        cell.followButtonClickHandler = { [weak self, weak cell] in
            guard let self = self else { return }
            let followState = self.dataStore.toggleFollow(for: item)
            if self.showingFollowVideos {
                self.tableView.reloadData()
            } else {
                cell?.applyFollowState(followState)
            }
        }
        cell.userButtonClickHandler = { [weak self] in
            self?.pushUserPage(with: item.user)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Tendi_PlayViewController()
        vc.videoItem = videoItems[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showChooseMoeView(for user: TendiLocalUser) {
        ChooseMoeView.show(from: self, targetUser: user) { [weak self] in
            self?.collectionView.reloadData()
            self?.tableView.reloadData()
        }
    }

    private func pushUserPage(with user: TendiLocalUser) {
        let userViewController = Tendi_UserViewController()
        userViewController.user = user
        userViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userViewController, animated: true)
    }

}
