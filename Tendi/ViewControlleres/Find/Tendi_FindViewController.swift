//
//  Tendi_FindViewController.swift
//  Tendi
//
//  Created by Mac on 2026/7/19.
//

import UIKit

class Tendi_FindViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    private let dataStore = TendiLocalDataStore.shared
    private var imageItems: [TendiFindPostItem] {
        dataStore.imageItems
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "Tendi_FindTableViewCell", bundle: nil), forCellReuseIdentifier: "find")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tableView.reloadData()
    }

    @IBAction func tendi_bananerClick(_ sender: Any) {
        guard let firstItem = imageItems.first else { return }
        pushDetail(with: firstItem)
    }
    
    @IBAction func tap_publishTextDynamic(_ sender: Any) {
        let postViewController = Tendi_PostViewController()
        postViewController.publishMode = .text
        postViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postViewController, animated: true)
    }
    

}
extension Tendi_FindViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let find = tableView.dequeueReusableCell(withIdentifier: "find", for: indexPath) as! Tendi_FindTableViewCell
        let item = imageItems[indexPath.row]
        find.backgroundColor = .clear
        find.selectionStyle = .none
        find.configure(
            with: item,
            likeState: dataStore.likeState(for: item),
            commentCount: dataStore.commentCount(for: item),
            followState: dataStore.followState(for: item)
        )
        find.moreButtonClickHandler = { [weak self] in
            self?.showChooseMoeView(for: item.user)
        }
        find.userButtonClickHandler = { [weak self] in
            self?.pushUserPage(with: item.user)
        }
        find.followButtonClickHandler = { [weak self, weak find] in
            guard let self = self else { return }
            let followState = self.dataStore.toggleFollow(for: item)
            find?.applyFollowState(followState)
        }
        find.likeButtonClickHandler = { [weak self, weak find] in
            guard let self = self else { return }
            let likeState = self.dataStore.toggleLike(for: item)
            find?.applyLikeState(likeState)
        }
        find.commentButtonClickHandler = { [weak self] in
            self?.pushDetail(with: item)
        }

        return find
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetail(with: imageItems[indexPath.row])
    }

    private func showChooseMoeView(for user: TendiLocalUser) {
        ChooseMoeView.show(from: self, targetUser: user) { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func pushDetail(with item: TendiFindPostItem) {
        let detail = Tendi_DetailsViewController()
        detail.postItem = item
        detail.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detail, animated: true)
    }

    private func pushUserPage(with user: TendiLocalUser) {
        let userViewController = Tendi_UserViewController()
        userViewController.user = user
        userViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userViewController, animated: true)
    }

}
