
import UIKit

enum TendiPersonListMode: Equatable {
    case followers
    case following
    case blacklist

    var title: String {
        switch self {
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        case .blacklist:
            return "Blacklist"
        }
    }
}

class Tendi_PersonViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var mode: TendiPersonListMode = .blacklist

    private let dataStore = TendiLocalDataStore.shared
    private var people: [TendiLocalUser] {
        switch mode {
        case .followers:
            return dataStore.currentFollowerUsers
        case .following:
            return dataStore.currentFollowingUsers
        case .blacklist:
            return dataStore.blockedUsers
        }
    }
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
        navigationItem.title = mode.title
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 66.1)/3, height: 137)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "Tendi_PersonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")
        collectionView.backgroundView = emptyStateView
        reloadPeople()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(peopleDidChange),
            name: .tendiBlockedUsersDidChange,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(peopleDidChange),
            name: .tendiFollowStateDidChange,
            object: nil
        )
    }

    @MainActor deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        reloadPeople()
    }

    private func reloadPeople() {
        emptyStateView.isHidden = people.isEmpty == false
        collectionView.reloadData()
    }

    @objc private func peopleDidChange() {
        reloadPeople()
    }

    private func confirmUnblock(_ user: TendiLocalUser) {
        TendiHUD.showPrompt(
            in: view,
            title: "Remove",
            message: "Remove \(user.nickname) from your blacklist?",
            primaryTitle: "Remove",
            secondaryTitle: "Cancel",
            primaryAction: { [weak self] in
                guard let self = self else { return }
                self.dataStore.unblockUser(user)
                self.reloadPeople()
            }
        )
    }

    private func toggleFollow(_ user: TendiLocalUser) {
        dataStore.toggleFollow(for: user)
        reloadPeople()
    }

    private func pushUserPage(with user: TendiLocalUser) {
        let userViewController = Tendi_UserViewController()
        userViewController.user = user
        userViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userViewController, animated: true)
    }
}

extension Tendi_PersonViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! Tendi_PersonCollectionViewCell
        cell.backgroundColor = .clear
        let user = people[indexPath.item]

        switch mode {
        case .followers, .following:
            let followState = dataStore.followState(for: user)
            let actionImageName = followState.isFollowed ? "person_followed" : "person_follow"
            cell.configure(with: user, actionImageName: actionImageName, showsActionButton: followState.canFollow)
            cell.removeButtonClickHandler = { [weak self] in
                self?.toggleFollow(user)
            }
        case .blacklist:
            cell.configure(with: user, actionImageName: "tendi_close")
            cell.removeButtonClickHandler = { [weak self] in
                self?.confirmUnblock(user)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = people[indexPath.item]

        if mode == .blacklist {
            confirmUnblock(user)
        } else {
            pushUserPage(with: user)
        }
    }
}
