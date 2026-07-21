
import UIKit

class Tendi_HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_more_button: UIButton!
    @IBOutlet weak var cell_follow_button: UIButton!
    @IBOutlet weak var cell_header_image: UIImageView!
    @IBOutlet weak var cell_bg_image: UIImageView!
    @IBOutlet weak var cell_like_button: UIButton!
    @IBOutlet weak var cell_connent_label: UILabel!
    @IBOutlet weak var cell_like_label: UILabel!
    @IBOutlet weak var cell_content_label: UILabel!
    @IBOutlet weak var cell_user_button: UIButton!
    var moreButtonClickHandler: (() -> Void)?
    var likeButtonClickHandler: (() -> Void)?
    var followButtonClickHandler: (() -> Void)?
    var userButtonClickHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        cell_more_button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        cell_like_button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell_follow_button.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        cell_user_button.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
        cell_like_button.setImage(UIImage(named: "tendi_zan_s"), for: .selected)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        moreButtonClickHandler = nil
        likeButtonClickHandler = nil
        followButtonClickHandler = nil
        userButtonClickHandler = nil
        cell_bg_image.image = UIImage(named: "cell_bg")
        cell_header_image.image = UIImage(named: "tendi_avatar")
        cell_like_button.isSelected = false
        cell_follow_button.isHidden = false
        cell_follow_button.isEnabled = true
        cell_like_label.text = "--"
        cell_connent_label.text = "--"
        cell_content_label.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc private func moreButtonTapped() {
        moreButtonClickHandler?()
    }

    @objc private func likeButtonTapped() {
        likeButtonClickHandler?()
    }

    @objc private func followButtonTapped() {
        followButtonClickHandler?()
    }

    @objc private func userButtonTapped() {
        userButtonClickHandler?()
    }

    func configure(
        with item: TendiHomeVideoItem,
        likeCount: Int,
        isLiked: Bool,
        commentCount: Int,
        followState: TendiUserFollowState
    ) {
        cell_bg_image.image = UIImage(named: item.coverImageName) ?? UIImage(named: "cell_bg")
        cell_bg_image.contentMode = .scaleAspectFill

        cell_header_image.image = UIImage(named: item.avatarImageName) ?? UIImage(named: "tendi_avatar")
        cell_header_image.layer.cornerRadius = 20
        cell_header_image.layer.masksToBounds = true

        cell_content_label.text = item.content
        applyLikeState(count: likeCount, isLiked: isLiked)
        cell_connent_label.text = "\(commentCount)"
        applyFollowState(followState)
        cell_user_button.accessibilityLabel = item.nickname
    }

    func applyLikeState(count: Int, isLiked: Bool) {
        cell_like_button.isSelected = isLiked
        cell_like_label.text = "\(count)"
    }

    func applyFollowState(_ state: TendiUserFollowState) {
        let followImageName = state.isFollowed ? "tendi_followed" : "tendi_follow"
        cell_follow_button.setImage(UIImage(named: followImageName), for: .normal)
        cell_follow_button.isHidden = state.canFollow == false
        cell_follow_button.isEnabled = state.canFollow
    }

}
