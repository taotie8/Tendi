
import AVFoundation
import UIKit

class Tendi_PlayViewController: BaseViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {

    @IBOutlet var tendi_commentView: UIView!
    @IBOutlet weak var commentContainerView: UIView!
    @IBOutlet weak var comment_text: UITextField!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var tendi_cover_image: UIImageView!
    @IBOutlet weak var tendi_header: UIImageView!
    @IBOutlet weak var tendi_follow_button: UIButton!
    @IBOutlet weak var tendi_name_label: UILabel!
    @IBOutlet weak var tendi_content_label: UILabel!
    @IBOutlet weak var tendi_like_button: UIButton!
    @IBOutlet weak var tendi_like_label: UILabel!
    @IBOutlet weak var tendi_comment_label: UILabel!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var pay_pause_button: UIButton!

    var videoItem: TendiHomeVideoItem?

    private let dataStore = TendiLocalDataStore.shared
    private var commentViewConstraints: [NSLayoutConstraint] = []
    private var player: AVQueuePlayer?
    private var playerLayer: AVPlayerLayer?
    private var playerLooper: AVPlayerLooper?
    private var commentItems: [TendiPostCommentItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let right_item = UIBarButtonItem(image: UIImage(named: "tendi_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigationRightItemClick))
        navigationItem.rightBarButtonItem = right_item
        setupCommentView()

        tableView.register(UINib(nibName: "Tendi_CommentsCell", bundle: nil), forCellReuseIdentifier: "comment")
        tableView.dataSource = self
        tableView.delegate = self

        pay_pause_button.addTarget(self, action: #selector(togglePlayback), for: .touchUpInside)
        tendi_like_button.setImage(UIImage(named: "tendi_zan_s"), for: .selected)
        configureVideoItem()
        reloadComments()
        setupVideoPlayer()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = playView.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshDynamicState()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }

    // 更多
    @objc func navigationRightItemClick() {
        ChooseMoeView.show(from: self)
    }

    // 关闭评论
    @IBAction func tendi_closeClick(_ sender: Any) {
        hideCommentView()
    }

    // 发送评论
    @IBAction func tendi_sendCommentClick(_ sender: Any) {
        guard tendi_commentView.superview != nil else {
            showCommentView()
            return
        }

        let comment = comment_text.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard comment.isEmpty == false else {
            comment_text.becomeFirstResponder()
            return
        }

        guard let videoItem = videoItem else { return }
        dataStore.addComment(comment, for: videoItem)
        comment_text.text = nil
        comment_text.resignFirstResponder()
        reloadComments()
        scrollToLatestComment()
    }

    //点赞喜欢和评论
    @IBAction func tendi_playLoveAndCommentsClick(_ sender: UIButton) {
        if sender.tag == 202 {
            showCommentView()
        } else {
            guard let videoItem = videoItem else {
                sender.isSelected.toggle()
                return
            }

            let likeState = dataStore.toggleLike(for: videoItem)
            applyLikeState(count: likeState.count, isLiked: likeState.isLiked)
        }
    }

    // 点击关注
    @IBAction func tendi_followClick(_ sender: Any) {
        guard let videoItem = videoItem else { return }
        let followState = dataStore.toggleFollow(for: videoItem)
        applyFollowState(followState)
    }
    // 进入用主页
    @IBAction func tendi_enterUserMainClick(_ sender: Any) {
        guard let user = videoItem?.user else { return }

        let userViewController = Tendi_UserViewController()
        userViewController.user = user
        userViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userViewController, animated: true)
    }

    @objc private func togglePlayback() {
        guard let player = player else { return }

        if player.timeControlStatus == .paused {
            player.play()
            pay_pause_button.setImage(nil, for: .normal)
        } else {
            player.pause()
            pay_pause_button.setImage(UIImage(named: "tendi_play_icon"), for: .normal)
        }
    }


}

private extension Tendi_PlayViewController {
    func configureVideoItem() {
        guard let videoItem = videoItem else { return }

        tendi_cover_image.image = UIImage(named: videoItem.coverImageName)
        tendi_cover_image.contentMode = .scaleAspectFill

        tendi_header.image = UIImage(named: videoItem.avatarImageName) ?? UIImage(named: "tendi_avatar")
        tendi_header.layer.cornerRadius = 20
        tendi_header.layer.masksToBounds = true

        tendi_name_label.text = videoItem.nickname
        tendi_content_label.text = videoItem.content
        refreshDynamicState()
    }

    func refreshDynamicState() {
        guard let videoItem = videoItem else { return }

        let likeState = dataStore.likeState(for: videoItem)
        applyLikeState(count: likeState.count, isLiked: likeState.isLiked)
        applyCommentCount(dataStore.commentCount(for: videoItem))
        applyFollowState(dataStore.followState(for: videoItem))
    }

    func applyLikeState(count: Int, isLiked: Bool) {
        tendi_like_button.isSelected = isLiked
        tendi_like_label.text = "\(count)"
    }

    func applyCommentCount(_ count: Int) {
        tendi_comment_label.text = "\(count)"
    }

    func applyFollowState(_ state: TendiUserFollowState) {
        let followImageName = state.isFollowed ? "tendi_followed" : "tendi_follow"
        tendi_follow_button.setImage(UIImage(named: followImageName), for: .normal)
        tendi_follow_button.isHidden = state.canFollow == false
        tendi_follow_button.isEnabled = state.canFollow
    }

    func reloadComments() {
        guard let videoItem = videoItem else {
            commentItems = []
            tableView.reloadData()
            applyCommentCount(0)
            return
        }

        commentItems = dataStore.comments(for: videoItem)
        tableView.reloadData()
        applyCommentCount(dataStore.commentCount(for: videoItem))
    }

    func scrollToLatestComment() {
        guard commentItems.isEmpty == false else { return }

        let indexPath = IndexPath(row: commentItems.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func setupVideoPlayer() {
        guard let videoURL = videoItem?.videoURL else { return }

        let playerItem = AVPlayerItem(url: videoURL)
        let player = AVQueuePlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = playView.bounds
        playView.layer.insertSublayer(playerLayer, at: 0)

        self.player = player
        self.playerLayer = playerLayer
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        pay_pause_button.setImage(nil, for: .normal)
        player.play()
    }

    func setupCommentView() {
        tendi_commentView.removeFromSuperview()
        tendi_commentView.alpha = 0
        comment_text.delegate = self
        commentContainerView.layer.cornerRadius = 26
        commentContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        commentContainerView.layer.masksToBounds = true
        commentContainerView.transform = CGAffineTransform(translationX: 0, y: commentContainerView.bounds.height)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(commentBackgroundTapped))
        tapGesture.delegate = self
        tendi_commentView.addGestureRecognizer(tapGesture)

        let contentTapGesture = UITapGestureRecognizer(target: self, action: #selector(commentContentTapped))
        contentTapGesture.delegate = self
        contentTapGesture.cancelsTouchesInView = false
        commentContainerView.addGestureRecognizer(contentTapGesture)
    }

    func showCommentView() {
        guard tendi_commentView.superview == nil else { return }
        let baseView: UIView = view
        let containerView = baseView.window ?? navigationController?.view ?? baseView

        reloadComments()
        tendi_commentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tendi_commentView)

        commentViewConstraints = [
            tendi_commentView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tendi_commentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tendi_commentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tendi_commentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(commentViewConstraints)

        containerView.layoutIfNeeded()
        tendi_commentView.layoutIfNeeded()
        commentContainerView.transform = CGAffineTransform(translationX: 0, y: commentContainerView.bounds.height)
        tendi_commentView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            self.tendi_commentView.alpha = 1
            self.commentContainerView.transform = .identity
        }
    }

    func hideCommentView() {
        guard tendi_commentView.superview != nil else { return }
        tendi_commentView.endEditing(true)

        UIView.animate(withDuration: 0.2, animations: {
            self.tendi_commentView.alpha = 0
            self.commentContainerView.transform = CGAffineTransform(translationX: 0, y: self.commentContainerView.bounds.height)
        }, completion: { _ in
            NSLayoutConstraint.deactivate(self.commentViewConstraints)
            self.commentViewConstraints.removeAll()
            self.tendi_commentView.removeFromSuperview()
        })
    }

    @objc func commentBackgroundTapped() {
        tendi_commentView.endEditing(true)
        hideCommentView()
    }

    @objc func commentContentTapped() {
        tendi_commentView.endEditing(true)
    }
}

extension Tendi_PlayViewController {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchedView = touch.view else { return true }

        if gestureRecognizer.view === commentContainerView {
            return touchedView !== comment_text && !touchedView.isDescendant(of: comment_text)
        }

        return !touchedView.isDescendant(of: commentContainerView)
    }
}

extension Tendi_PlayViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension Tendi_PlayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! Tendi_CommentsCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(with: commentItems[indexPath.row])

        return cell
    }
}
