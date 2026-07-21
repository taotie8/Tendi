
import UIKit

class Tendi_DetailsHeaderCell: UITableViewCell {

    @IBOutlet weak var detail_post_image: UIImageView!
    @IBOutlet weak var detail_content_label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        detail_post_image.layer.cornerRadius = 18
        detail_post_image.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        detail_post_image.image = UIImage(named: "cell_bg")
        detail_content_label.text = nil
    }

    func configure(with item: TendiFindPostItem) {
        detail_post_image.image = UIImage(named: item.imageName) ?? UIImage(named: "cell_bg")
        detail_content_label.text = item.content
    }

}
