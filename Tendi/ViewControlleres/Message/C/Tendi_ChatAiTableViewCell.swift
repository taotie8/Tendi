
import UIKit

class Tendi_ChatAiTableViewCell: UITableViewCell {
    static let reuseIdentifier = "Tendi_ChatAiTableViewCell"

    @IBOutlet weak var ai_avatar: UIImageView!
    @IBOutlet weak var tendi_bgView: UIView!
    @IBOutlet weak var ai_chat_label: UILabel!
    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = UIColor.black
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        ai_avatar.layer.cornerRadius = 15
        ai_avatar.layer.masksToBounds = true
        tendi_bgView.layer.cornerRadius = 12
        tendi_bgView.layer.borderWidth = 1
        tendi_bgView.layer.borderColor = UIColor(red: 143/255, green: 255/255, blue: 178/255, alpha: 1.0).cgColor//UIColor.black.cgColor
        tendi_bgView.backgroundColor = .clear
        ai_chat_label.numberOfLines = 0
        tendi_bgView.addSubview(loadingIndicatorView)
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: tendi_bgView.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: tendi_bgView.centerYAnchor)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configure(with item: TendiAiChatMessageItem) {
        loadingIndicatorView.stopAnimating()
        ai_chat_label.isHidden = false
        ai_chat_label.text = item.content
    }

    func configureLoading() {
        ai_chat_label.text = nil
        ai_chat_label.isHidden = true
        loadingIndicatorView.startAnimating()
    }
    
}
