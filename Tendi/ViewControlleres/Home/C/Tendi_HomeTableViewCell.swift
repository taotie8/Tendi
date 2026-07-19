
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cell_more_button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        moreButtonClickHandler = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc private func moreButtonTapped() {
        moreButtonClickHandler?()
    }
    
}
