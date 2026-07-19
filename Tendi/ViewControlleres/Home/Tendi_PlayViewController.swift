
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
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var pay_pause_button: UIButton!
    
    private var commentViewConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let right_item = UIBarButtonItem(image: UIImage(named: "tendi_more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigationRightItemClick))
        navigationItem.rightBarButtonItem = right_item
        setupCommentView()
        
        tableView.register(UINib(nibName: "Tendi_CommentsCell", bundle: nil), forCellReuseIdentifier: "comment")
        tableView.dataSource = self
        tableView.delegate = self
    }
    // 更多
    @objc func navigationRightItemClick() {
        guard let containerView = view.window ?? tabBarController?.view ?? view else { return }
        ChooseMoeView.show(in: containerView, reportAction: { [weak self] in
            let reportDetailViewController = ReportDetailViewController()
            reportDetailViewController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(reportDetailViewController, animated: true)
        })
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

        comment_text.text = nil
        comment_text.resignFirstResponder()
    }
    
    //点赞喜欢和评论
    @IBAction func tendi_playLoveAndCommentsClick(_ sender: UIButton) {
        if sender.tag == 202 {
            showCommentView()
        } else {
            sender.isSelected.toggle()
        }
    }
    
    // 点击关注
    @IBAction func tendi_followClick(_ sender: Any) {
        
    }
    // 进入用主页
    @IBAction func tendi_enterUserMainClick(_ sender: Any) {
        
    }
    
    
}

private extension Tendi_PlayViewController {
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
        guard tendi_commentView.superview == nil,
              let containerView = view.window ?? navigationController?.view ?? view else { return }

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
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! Tendi_CommentsCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
}
