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
        tendi_bg.layer.cornerRadius = 12
        tendi_bg.layer.borderWidth = 1
//        tendi_bg.layer.borderColor = UIColor(red: 248/255, green: 255/255, blue: 89/255, alpha: 1.0).cgColor
        tendi_bg.layer.borderColor = UIColor.black.cgColor
        tendi_content.numberOfLines = 0
        tendi_bg.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with item: TendiChatMessageItem) {
        tendi_avatar.image = UIImage(named: item.avatarImageName) ?? UIImage(named: "tendi_avatar")
        tendi_content.text = item.content
    }

}
