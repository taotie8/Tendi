//
//  Tendi_ChatTableViewCell.swift
//  Tendi
//
//  Created by Mac on 2026/7/21.
//

import UIKit

class Tendi_ChatTableViewCell: UITableViewCell {
    static let reuseIdentifier = "Tendi_ChatTableViewCell"

    @IBOutlet weak var tendi_avatar: UIImageView!
    @IBOutlet weak var tendi_content: UILabel!
    @IBOutlet weak var tendi_bg: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        tendi_avatar.layer.cornerRadius = 15
        tendi_avatar.layer.masksToBounds = true
        tendi_bg.layer.cornerRadius = 15
        tendi_bg.layer.borderWidth = 1
        tendi_bg.layer.borderColor = UIColor.black.cgColor
        tendi_content.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with item: TendiChatMessageItem) {
        tendi_avatar.image = UIImage(named: item.avatarImageName) ?? UIImage(named: "tendi_avatar")
        tendi_content.text = item.content
        tendi_bg.backgroundColor = item.isOutgoing
            ? UIColor(red: 0.91, green: 1.0, blue: 0.34, alpha: 1)
            : .white
    }

}
