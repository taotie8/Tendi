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

    override func awakeFromNib() {
        super.awakeFromNib()
        comment_avatar_image.layer.cornerRadius = 20
        comment_avatar_image.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        comment_avatar_image.image = UIImage(named: "tendi_avatar")
        comment_name_label.text = nil
        comment_content_label.text = nil
    }

    func configure(with item: TendiPostCommentItem) {
        comment_avatar_image.image = UIImage(named: item.avatarImageName) ?? UIImage(named: "tendi_avatar")
        comment_name_label.text = item.nickname
        comment_content_label.text = item.content
    }

}
