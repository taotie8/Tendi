
import UIKit

class Tendi_HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 18
        coverImageView.contentMode = .scaleAspectFill
        titleLabel.textColor = .white
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = UIImage(named: "home_share")
        titleLabel.text = nil
    }

    func configureAsPostEntry() {
        coverImageView.image = UIImage(named: "home_share")
        titleLabel.text = "Post"
        accessibilityLabel = "Post"
    }

    func configure(with item: TendiHomeVideoItem) {
        coverImageView.image = UIImage(named: item.coverImageName) ?? UIImage(named: "cell_bg")
        titleLabel.text = item.nickname
        accessibilityLabel = item.nickname
    }

}
