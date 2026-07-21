//
//  Tendi_MessageTableViewCell.swift
//  Tendi
//
//  Created by JIAO on 2026/7/20.
//

import UIKit

class Tendi_MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var tendi_avatar: UIImageView!
    @IBOutlet weak var tendi_name: UILabel!
    @IBOutlet weak var tendi_content: UILabel!
    @IBOutlet weak var tendi_time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        tendi_avatar.layer.cornerRadius = 20
        tendi_avatar.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configure(with item: TendiChatPreviewItem) {
        tendi_avatar.image = UIImage(named: item.avatarImageName) ?? UIImage(named: "tendi_avatar")
        tendi_name.text = item.title
        tendi_content.text = item.previewText
        tendi_time.text = formattedTime(from: item.lastMessage?.createdAt)
    }

    private func formattedTime(from value: String?) -> String {
        guard let value = value,
              let date = Self.isoDateFormatter.date(from: value) else {
            return ""
        }

        return Self.timeFormatter.string(from: date)
    }

    private static let isoDateFormatter = ISO8601DateFormatter()
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
