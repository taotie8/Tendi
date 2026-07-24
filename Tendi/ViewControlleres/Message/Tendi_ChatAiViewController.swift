
import UIKit

class Tendi_ChatAiViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var tendi_tableView: UITableView!
    @IBOutlet weak var tendi_textFiled: UITextField!
    @IBOutlet weak var inputContainerBottomConstraint: NSLayoutConstraint!

    private let dataStore = TendiLocalDataStore.shared
    private var messageItems: [TendiAiChatMessageItem] = []
    private var isAiReplyLoading = false
    private var pendingAiReplyWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureInput()
        reloadMessages(animated: false)
        registerKeyboardNotifications()
        addDismissKeyboardGesture()
    }

    @MainActor deinit {
        pendingAiReplyWorkItem?.cancel()
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadMessages(animated: false)
    }

    @IBAction func sendAiMessage(_ sender: UIButton) {
        sendCurrentMessage()
    }

    private func configureTableView() {
        tendi_tableView.register(
            UINib(nibName: "Tendi_ChatAiTableViewCell", bundle: nil),
            forCellReuseIdentifier: Tendi_ChatAiTableViewCell.reuseIdentifier
        )
        tendi_tableView.register(
            UINib(nibName: "Tendi_ChatTableViewCell", bundle: nil),
            forCellReuseIdentifier: Tendi_ChatTableViewCell.reuseIdentifier
        )
        tendi_tableView.dataSource = self
        tendi_tableView.delegate = self
        tendi_tableView.separatorStyle = .none
        tendi_tableView.backgroundColor = .clear
        tendi_tableView.rowHeight = UITableView.automaticDimension
        tendi_tableView.estimatedRowHeight = 72
        tendi_tableView.keyboardDismissMode = .interactive
        tendi_tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }

    private func configureInput() {
        tendi_textFiled.delegate = self
        tendi_textFiled.returnKeyType = .send
        tendi_textFiled.enablesReturnKeyAutomatically = true
    }

    @discardableResult
    private func sendCurrentMessage() -> Bool {
        guard isAiReplyLoading == false else { return false }

        let message = tendi_textFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard message.isEmpty == false else {
            tendi_textFiled.becomeFirstResponder()
            return false
        }

        guard dataStore.addAiChatMessage(message, isOutgoing: true) != nil else {
            return false
        }

        tendi_textFiled.text = nil
        reloadMessages(animated: true)
        addAiReply(for: message)
        return true
    }

    private func addAiReply(for message: String) {
        let reply = makeAiReply(for: message)
        isAiReplyLoading = true
        reloadMessages(animated: true)

        pendingAiReplyWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.isAiReplyLoading = false
            self.dataStore.addAiChatMessage(reply, isOutgoing: false)
            self.reloadMessages(animated: true)
        }
        pendingAiReplyWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.0...2.0), execute: workItem)
    }

    private func makeAiReply(for message: String) -> String {
        let lowercasedMessage = message.lowercased()

        if lowercasedMessage.contains("hello") || lowercasedMessage.contains("hi") {
            return "Hi, ready to talk tennis? Tell me about your match, training, or the shot you want to improve."
        }

        if lowercasedMessage.contains("sad") || lowercasedMessage.contains("bad") {
            return "Tough sets happen. Take a breath, reset your rhythm, and tell me which point or shot bothered you most."
        }

        if lowercasedMessage.contains("?") {
            return "Good tennis question. We can break it down by footwork, timing, contact point, and recovery."
        }

        let replies = [
            "Keep the rally steady first. Once your rhythm is there, look for the right ball to attack.",
            "Try focusing on your split step and first move. A cleaner start makes every stroke easier.",
            "For serves, think toss, balance, then contact. Power comes after the motion feels smooth.",
            "If the point gets tight, aim cross-court with margin. Make your opponent play one more ball.",
            "Your forehand will feel better when you meet the ball in front and finish through the court.",
            "On return games, choose a simple target early. Deep middle is often a smart first answer.",
            "A good net approach starts before the volley. Pick the right short ball and move in with purpose.",
            "Between points, reset like a pro: breathe, check the score, choose the next pattern."
        ]
        let index = abs(message.hashValue % replies.count)
        return replies[index]
    }

    private func reloadMessages(animated: Bool) {
        messageItems = dataStore.aiChatMessages()
        tendi_tableView.reloadData()
        scrollToLatestMessage(animated: animated)
    }

    private func scrollToLatestMessage(animated: Bool) {
        let visibleRowsCount = numberOfVisibleRows()
        guard visibleRowsCount > 0 else { return }

        let lastRow = visibleRowsCount - 1
        tendi_tableView.scrollToRow(at: IndexPath(row: lastRow, section: 0), at: .bottom, animated: animated)
    }

    private func numberOfVisibleRows() -> Int {
        messageItems.count + (isAiReplyLoading ? 1 : 0)
    }

    private func addDismissKeyboardGesture() {
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

extension Tendi_ChatAiViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfVisibleRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isAiReplyLoading && indexPath.row == messageItems.count {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Tendi_ChatAiTableViewCell.reuseIdentifier,
                for: indexPath
            ) as! Tendi_ChatAiTableViewCell
            cell.configureLoading()
            return cell
        }

        let item = messageItems[indexPath.row]

        if item.isOutgoing {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Tendi_ChatTableViewCell.reuseIdentifier,
                for: indexPath
            ) as! Tendi_ChatTableViewCell
            cell.configure(content: item.content, avatarImageName: item.avatarImageName)
            return cell
        }

        let cell = tableView.dequeueReusableCell(
            withIdentifier: Tendi_ChatAiTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! Tendi_ChatAiTableViewCell
        cell.configure(with: item)
        return cell
    }
}
