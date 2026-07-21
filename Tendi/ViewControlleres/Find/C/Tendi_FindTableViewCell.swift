
import UIKit

class Tendi_FindTableViewCell: UITableViewCell {

    @IBOutlet weak var find_header_image: UIImageView!
    @IBOutlet weak var find_follow_button: UIButton!
    @IBOutlet weak var find_more_button: UIButton!
    @IBOutlet weak var find_user_button: UIButton!
    @IBOutlet weak var find_post_image: UIImageView!
    @IBOutlet weak var find_like_button: UIButton!
    @IBOutlet weak var find_comment_button: UIButton!
    @IBOutlet weak var find_like_label: UILabel!
    @IBOutlet weak var find_comment_label: UILabel!
    @IBOutlet weak var find_content_label: UILabel!

    var moreButtonClickHandler: (() -> Void)?
    var userButtonClickHandler: (() -> Void)?
    var followButtonClickHandler: (() -> Void)?
    var likeButtonClickHandler: (() -> Void)?
    var commentButtonClickHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        find_more_button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        find_user_button.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
        find_follow_button.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        find_like_button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        find_comment_button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        find_like_button.setImage(UIImage(named: "tendi_zan_s"), for: .selected)
        find_header_image.layer.cornerRadius = 20
        find_header_image.layer.masksToBounds = true
        find_post_image.layer.cornerRadius = 18
        find_post_image.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        moreButtonClickHandler = nil
        userButtonClickHandler = nil
        followButtonClickHandler = nil
        likeButtonClickHandler = nil
        commentButtonClickHandler = nil
        find_header_image.image = UIImage(named: "tendi_avatar")
        find_post_image.image = UIImage(named: "cell_bg")
        find_like_button.isSelected = false
        find_like_label.text = "--"
        find_comment_label.text = "--"
        find_content_label.text = nil
        find_follow_button.isHidden = false
        find_follow_button.isEnabled = true
    }

    func configure(
        with item: TendiFindPostItem,
        likeState: TendiPostLikeState,
        commentCount: Int,
        followState: TendiUserFollowState
    ) {
        find_header_image.image = UIImage(named: item.avatarImageName) ?? UIImage(named: "tendi_avatar")
        find_post_image.image = UIImage(named: item.imageName) ?? UIImage(named: "cell_bg")
        find_content_label.text = item.content
        find_user_button.accessibilityLabel = item.nickname
        applyLikeState(likeState)
        applyCommentCount(commentCount)
        applyFollowState(followState)
    }

    func applyLikeState(_ state: TendiPostLikeState) {
        find_like_button.isSelected = state.isLiked
        find_like_label.text = "\(state.count)"
    }

    func applyCommentCount(_ count: Int) {
        find_comment_label.text = "\(count)"
    }

    func applyFollowState(_ state: TendiUserFollowState) {
        let followImageName = state.isFollowed ? "tendi_followed" : "tendi_follow"
        find_follow_button.setImage(UIImage(named: followImageName), for: .normal)
        find_follow_button.isHidden = state.canFollow == false
        find_follow_button.isEnabled = state.canFollow
    }

    @objc private func moreButtonTapped() {
        moreButtonClickHandler?()
    }

    @objc private func userButtonTapped() {
        userButtonClickHandler?()
    }

    @objc private func followButtonTapped() {
        followButtonClickHandler?()
    }

    @objc private func likeButtonTapped() {
        likeButtonClickHandler?()
    }

    @objc private func commentButtonTapped() {
        commentButtonClickHandler?()
    }

}
