
import UIKit

class Tendi_UserCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var user_video_image: UIImageView!
    @IBOutlet weak var user_like_button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        user_like_button.setImage(UIImage(named: "tendi_zan_s"), for: .selected)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        user_video_image.image = UIImage(named: "cell_bg")
        user_like_button.isSelected = false
    }

    func configure(with item: TendiUserPostItem, likeState: TendiPostLikeState) {
        user_video_image.image = UIImage(named: item.thumbnailImageName) ?? UIImage(named: "cell_bg")
        user_like_button.isSelected = likeState.isLiked
    }

}
