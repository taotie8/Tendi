
import UIKit

class Tendi_DetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detail_header_image: UIImageView!
    @IBOutlet weak var detail_name_label: UILabel!
    @IBOutlet weak var detail_follow_button: UIButton!
    @IBOutlet weak var detail_text_field: UITextField!
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!

    var postItem: TendiFindPostItem?

    private let dataStore = TendiLocalDataStore.shared
    private var commentItems: [TendiPostCommentItem] = []
    private var baseTableBottomConstant: CGFloat = 87

    override func viewDidLoad() {
        super.viewDidLoad()
        baseTableBottomConstant = tableViewBottomConstraint.constant
        tableView.register(UINib(nibName: "Tendi_DetailsHeaderCell", bundle: nil), forCellReuseIdentifier: "header")
        tableView.register(UINib(nibName: "Tendi_CommentsCell", bundle: nil), forCellReuseIdentifier: "comment")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        detail_text_field.delegate = self
        detail_text_field.returnKeyType = .send
        detail_text_field.clearButtonMode = .whileEditing
        setupKeyboardDismissGesture()
        registerKeyboardNotifications()
        configurePost()
        reloadComments()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        refreshDynamicState()
    }

    @IBAction func nav_backClick(_ sender: Any) {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func detail_followClick(_ sender: Any) {
        guard let postItem = postItem else { return }
        let followState = dataStore.toggleFollow(for: postItem)
        applyFollowState(followState)
    }

    @IBAction func detail_moreClick(_ sender: Any) {
        ChooseMoeView.show(from: self, targetUser: postItem?.user) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func pushReportDetail() {
        detail_text_field.resignFirstResponder()
        let reportDetailViewController = ReportDetailViewController()
        reportDetailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(reportDetailViewController, animated: true)
    }

    @IBAction func detail_userClick(_ sender: Any) {
        guard let user = postItem?.user else { return }
        let userViewController = Tendi_UserViewController()
        userViewController.user = user
        userViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userViewController, animated: true)
    }

    @IBAction func detail_sendCommentClick(_ sender: Any) {
        submitCurrentComment()
    }

    private func submitCurrentComment() {
        let comment = detail_text_field.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard comment.isEmpty == false else {
            detail_text_field.becomeFirstResponder()
            return
        }

        guard let postItem = postItem else { return }
        dataStore.addComment(comment, for: postItem)
        detail_text_field.text = nil
        detail_text_field.resignFirstResponder()
        reloadComments(animated: true)
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

    private func reloadComments(animated: Bool = false) {
        guard let postItem = postItem else {
            commentItems = []
            tableView.reloadData()
            return
        }

        commentItems = dataStore.comments(for: postItem)
        if animated {
            tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        } else {
            tableView.reloadData()
        }
    }

    private func scrollToLatestComment() {
        guard commentItems.isEmpty == false else { return }

        let indexPath = IndexPath(row: commentItems.count - 1, section: 1)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitCurrentComment()
        return true
    }

    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        updateKeyboardLayout(with: notification, isHiding: false)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        updateKeyboardLayout(with: notification, isHiding: true)
    }

    private func updateKeyboardLayout(with notification: Notification, isHiding: Bool) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        let curveValue = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
            ?? UInt(UIView.AnimationCurve.easeInOut.rawValue)
        let options = UIView.AnimationOptions(rawValue: curveValue << 16)

        let keyboardOverlap: CGFloat
        if isHiding {
            keyboardOverlap = 0
        } else if let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = view.convert(frameValue.cgRectValue, from: nil)
            keyboardOverlap = max(0, view.bounds.maxY - keyboardFrame.minY)
        } else {
            keyboardOverlap = 0
        }

        inputContainerBottomConstraint.constant = keyboardOverlap
        tableViewBottomConstraint.constant = baseTableBottomConstant + keyboardOverlap

        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            if self.detail_text_field.isFirstResponder {
                self.scrollToLatestComment()
            }
        }
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
        header.moreButtonClickHandler = { [weak self] in
            self?.pushReportDetail()
        }
        return header
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 1, commentItems.isEmpty else { return nil }

        let containerView = UIView()
        containerView.backgroundColor = .clear

        let imageView = UIImageView(image: UIImage(named: "tendi_yet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 103)
        ])

        return containerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 1 && commentItems.isEmpty ? 145 : .leastNormalMagnitude
    }
}
