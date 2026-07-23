
import UIKit

class Tendi_ChatViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var user_header: UIImageView!
    @IBOutlet weak var user_name_label: UILabel!
    @IBOutlet weak var tendi_textFiled: UITextField!
    @IBOutlet weak var inputContainerBottomConstraint: NSLayoutConstraint!

    var user: TendiLocalUser?

    private let dataStore = TendiLocalDataStore.shared
    private var messageItems: [TendiChatMessageItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tendi_textFiled.delegate = self
        configureUser()
        reloadMessages(animated: false)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        registerKeyboardNotifications()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        reloadMessages(animated: false)
    }

    @IBAction func nav_backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func nav_morebuttonAndCenterClick(_ sender: UIButton) {
        if sender.currentImage == nil {
            guard let user = user else { return }
            let userViewController = Tendi_UserViewController()
            userViewController.user = user
            userViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(userViewController, animated: true)
            return
        }

        ChooseMoeView.show(from: self, targetUser: user) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }

    @IBAction func sendChatMessageVideoChat(_ sender: UIButton) {
        if sender.tag == 986 {
            pushVideoChatPage()
            return
        }

        sendCurrentMessage()
    }

    private func pushVideoChatPage() {
        guard let user = user else { return }

        guard dataStore.isBlocked(user) == false else {
            tendi_textFiled.resignFirstResponder()
            TendiHUD.showToast("This user is blocked.", in: view)
            return
        }

        view.endEditing(true)
        let videoChatViewController = Tendi_VideoChatViewController()
        videoChatViewController.user = user
        videoChatViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(videoChatViewController, animated: true)
    }

    private func configureTableView() {
        tableView.register(
            UINib(nibName: "Tendi_ChatTableViewCell", bundle: nil),
            forCellReuseIdentifier: Tendi_ChatTableViewCell.reuseIdentifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.keyboardDismissMode = .interactive
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }

    @discardableResult
    private func sendCurrentMessage() -> Bool {
        let message = tendi_textFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard message.isEmpty == false else {
            tendi_textFiled.becomeFirstResponder()
            return false
        }

        guard let user = user else {
            return false
        }

        guard dataStore.isBlocked(user) == false else {
            tendi_textFiled.resignFirstResponder()
            TendiHUD.showToast("This user is blocked.", in: view)
            return false
        }

        guard dataStore.addChatMessage(message, to: user) != nil else {
            return false
        }

        tendi_textFiled.text = nil
        tendi_textFiled.resignFirstResponder()
        reloadMessages(animated: true)
        return true
    }

    private func configureUser() {
        guard let user = user else { return }

        user_header.image = UIImage(named: user.avatarImageName) ?? UIImage(named: "tendi_avatar")
        user_header.layer.cornerRadius = 20
        user_header.layer.masksToBounds = true
        user_name_label.text = user.nickname
    }

    private func reloadMessages(animated: Bool) {
        guard let user = user else {
            messageItems = []
            tableView.reloadData()
            return
        }

        messageItems = dataStore.chatMessages(with: user)
        tableView.reloadData()
        scrollToLatestMessage(animated: animated)
    }

    private func scrollToLatestMessage(animated: Bool) {
        guard messageItems.isEmpty == false else { return }

        let lastRow = messageItems.count - 1
        tableView.scrollToRow(at: IndexPath(row: lastRow, section: 0), at: .bottom, animated: animated)
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

        if isHiding {
            inputContainerBottomConstraint.constant = 0
        } else if let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = view.convert(frameValue.cgRectValue, from: nil)
            inputContainerBottomConstraint.constant = max(0, view.bounds.maxY - keyboardFrame.minY)
        }

        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.scrollToLatestMessage(animated: false)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendCurrentMessage()
        return true
    }

}

extension Tendi_ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messageItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Tendi_ChatTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! Tendi_ChatTableViewCell
        cell.configure(with: messageItems[indexPath.row])
        return cell
    }
}
