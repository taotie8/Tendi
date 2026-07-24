//
//  Tendi_FindViewController.swift
//  Tendi
//
//  Created by Mac on 2026/7/19.
//

import UIKit

class Tendi_FindViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private var unlockAIView: UIView!
    @IBOutlet private var insufficientBalanceView: UIView!

    private let dataStore = TendiLocalDataStore.shared
    private let aiFeatureUseCost = TendiLocalDataStore.aiFeatureUseCost
    private weak var currentPopupView: UIView?

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
        if dataStore.canSpendCoins(aiFeatureUseCost) {
            showCenterPopup(unlockAIView)
        } else {
            showCenterPopup(insufficientBalanceView)
        }
    }

    @IBAction func unlockAIConfirmClick(_ sender: Any) {
        guard dataStore.spendCoins(aiFeatureUseCost) else {
            dismissCurrentPopup { [weak self] in
                guard let self else { return }
                self.showCenterPopup(self.insufficientBalanceView)
            }
            return
        }

        dismissCurrentPopup { [weak self] in
            self?.pushChatAIPage()
        }
    }

    @IBAction func unlockAICloseClick(_ sender: Any) {
        dismissCurrentPopup()
    }

    @IBAction func insufficientBalanceRechargeClick(_ sender: Any) {
        dismissCurrentPopup { [weak self] in
            let rechargeViewController = Tendi_DallarViewController()
            rechargeViewController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(rechargeViewController, animated: true)
        }
    }

    @IBAction func insufficientBalanceCloseClick(_ sender: Any) {
        dismissCurrentPopup()
    }
    
    @IBAction func tap_publishTextDynamic(_ sender: Any) {
        let postViewController = Tendi_PostViewController()
        postViewController.publishMode = .text
        postViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postViewController, animated: true)
    }

    private func pushChatAIPage() {
        let vc = Tendi_ChatAiViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showCenterPopup(_ popupView: UIView) {
        currentPopupView?.removeFromSuperview()

        let containerView = navigationController?.view ?? view
        popupView.removeFromSuperview()
        popupView.frame = containerView?.bounds ?? view.bounds
        popupView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popupView.alpha = 0

        let contentViews = popupContentViews(in: popupView)
        contentViews.forEach { contentView in
            contentView.alpha = 0
            contentView.transform = CGAffineTransform(scaleX: 0.72, y: 0.72)
        }

        containerView?.addSubview(popupView)
        currentPopupView = popupView

        UIView.animate(withDuration: 0.16) {
            popupView.alpha = 1
        }

        UIView.animate(
            withDuration: 0.34,
            delay: 0,
            usingSpringWithDamping: 0.72,
            initialSpringVelocity: 0.35,
            options: [.curveEaseOut]
        ) {
            contentViews.forEach { contentView in
                contentView.alpha = 1
                contentView.transform = .identity
            }
        }
    }

    private func dismissCurrentPopup(completion: (() -> Void)? = nil) {
        guard let popupView = currentPopupView else {
            completion?()
            return
        }

        currentPopupView = nil
        let contentViews = popupContentViews(in: popupView)
        UIView.animate(
            withDuration: 0.16,
            animations: {
                popupView.alpha = 0
                contentViews.forEach { contentView in
                    contentView.alpha = 0
                    contentView.transform = CGAffineTransform(scaleX: 0.86, y: 0.86)
                }
            },
            completion: { _ in
                contentViews.forEach { contentView in
                    contentView.alpha = 1
                    contentView.transform = .identity
                }
                popupView.removeFromSuperview()
                completion?()
            }
        )
    }

    private func popupContentViews(in popupView: UIView) -> [UIView] {
        Array(popupView.subviews.dropFirst())
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
