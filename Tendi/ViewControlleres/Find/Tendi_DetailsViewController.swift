
import UIKit

class Tendi_DetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detail_header_image: UIImageView!
    @IBOutlet weak var detail_name_label: UILabel!
    @IBOutlet weak var detail_follow_button: UIButton!
    @IBOutlet weak var detail_text_field: UITextField!

    var postItem: TendiFindPostItem?

    private let dataStore = TendiLocalDataStore.shared
    private var commentItems: [TendiPostCommentItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "Tendi_DetailsHeaderCell", bundle: nil), forCellReuseIdentifier: "header")
        tableView.register(UINib(nibName: "Tendi_CommentsCell", bundle: nil), forCellReuseIdentifier: "comment")
        tableView.dataSource = self
        tableView.delegate = self
        detail_text_field.delegate = self
        configurePost()
        reloadComments()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        refreshDynamicState()
    }

    @IBAction func nav_backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func detail_followClick(_ sender: Any) {
        guard let postItem = postItem else { return }
        let followState = dataStore.toggleFollow(for: postItem)
        applyFollowState(followState)
    }

    @IBAction func detail_moreClick(_ sender: Any) {
        ChooseMoeView.show(from: self)
    }

    @IBAction func detail_userClick(_ sender: Any) {
        guard let user = postItem?.user else { return }
        let userViewController = Tendi_UserViewController()
        userViewController.user = user
        userViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userViewController, animated: true)
    }

    @IBAction func detail_sendCommentClick(_ sender: Any) {
        let comment = detail_text_field.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard comment.isEmpty == false else {
            detail_text_field.becomeFirstResponder()
            return
        }

        guard let postItem = postItem else { return }
        dataStore.addComment(comment, for: postItem)
        detail_text_field.text = nil
        detail_text_field.resignFirstResponder()
        reloadComments()
        scrollToLatestComment()
    }

    private func configurePost() {
        guard let postItem = postItem else { return }

        detail_header_image.image = UIImage(named: postItem.avatarImageName) ?? UIImage(named: "tendi_avatar")
        detail_header_image.layer.cornerRadius = 20
        detail_header_image.layer.masksToBounds = true
        detail_name_label.text = postItem.nickname
        refreshDynamicState()
    }

    private func refreshDynamicState() {
        guard let postItem = postItem else { return }
        applyFollowState(dataStore.followState(for: postItem))
        reloadComments()
    }

    private func applyFollowState(_ state: TendiUserFollowState) {
        let followImageName = state.isFollowed ? "tendi_followed" : "tendi_follow"
        detail_follow_button.setImage(UIImage(named: followImageName), for: .normal)
        detail_follow_button.isHidden = state.canFollow == false
        detail_follow_button.isEnabled = state.canFollow
    }

    private func reloadComments() {
        guard let postItem = postItem else {
            commentItems = []
            tableView.reloadData()
            return
        }

        commentItems = dataStore.comments(for: postItem)
        tableView.reloadData()
    }

    private func scrollToLatestComment() {
        guard commentItems.isEmpty == false else { return }

        let indexPath = IndexPath(row: commentItems.count - 1, section: 1)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension Tendi_DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return postItem == nil ? 0 : 1
        }

        return commentItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! Tendi_DetailsHeaderCell
            header.backgroundColor = .clear
            header.selectionStyle = .none
            if let postItem = postItem {
                header.configure(with: postItem)
            }
            return header
        }

        let header = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! Tendi_CommentsCell
        header.backgroundColor = .clear
        header.selectionStyle = .none
        header.configure(with: commentItems[indexPath.row])
        return header
    }
}
