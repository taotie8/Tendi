//
//  Tendi_CommentsCell.swift
//  Tendi
//
//  Created by Mac on 2026/7/19.
//

import UIKit

class Tendi_CommentsCell: UITableViewCell {

    @IBOutlet weak var comment_avatar_image: UIImageView!
    @IBOutlet weak var comment_name_label: UILabel!
    @IBOutlet weak var comment_content_label: UILabel!
    @IBOutlet weak var comment_more_button: UIButton!
    
    var moreButtonClickHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        comment_avatar_image.layer.cornerRadius = 20
        comment_avatar_image.layer.masksToBounds = true
        comment_more_button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        moreButtonClickHandler = nil
        comment_avatar_image.image = UIImage(named: "tendi_avatar")
        comment_name_label.text = nil
        comment_content_label.text = nil
    }

    func configure(with item: TendiPostCommentItem) {
        comment_avatar_image.image = UIImage(named: item.avatarImageName) ?? UIImage(named: "tendi_avatar")
        comment_name_label.text = item.nickname
        comment_content_label.text = item.content
    }
    
    @objc private func moreButtonTapped() {
        moreButtonClickHandler?()
    }

}
