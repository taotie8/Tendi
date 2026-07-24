
import UIKit

class Tendi_UserCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var user_video_image: UIImageView!
    @IBOutlet weak var user_like_button: UIButton!

    var likeButtonClickHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        user_like_button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        user_like_button.setImage(UIImage(named: "tendi_zan_s"), for: .selected)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        likeButtonClickHandler = nil
        user_video_image.image = UIImage(named: "cell_bg")
        user_like_button.isSelected = false
    }

    func configure(with item: TendiUserPostItem, likeState: TendiPostLikeState) {
        user_video_image.image = UIImage(named: item.thumbnailImageName) ?? UIImage(named: "cell_bg")
        user_like_button.isSelected = likeState.isLiked
    }

    func applyLikeState(_ state: TendiPostLikeState) {
        user_like_button.isSelected = state.isLiked
    }

    @objc private func likeButtonTapped() {
        likeButtonClickHandler?()
    }

}
