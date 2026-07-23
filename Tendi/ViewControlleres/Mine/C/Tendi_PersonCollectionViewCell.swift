//
//  Tendi_PersonCollectionViewCell.swift
//  Tendi
//
//  Created by JIAO on 2026/7/20.
//

import UIKit

class Tendi_PersonCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nicknameLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!

    var removeButtonClickHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        nicknameLabel.textAlignment = .center
        nicknameLabel.adjustsFontSizeToFitWidth = true
        nicknameLabel.minimumScaleFactor = 0.72
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        removeButtonClickHandler = nil
        removeButton.isHidden = false
        removeButton.isEnabled = true
        removeButton.setImage(UIImage(named: "tendi_close"), for: .normal)
    }

    func configure(with user: TendiLocalUser, actionImageName: String = "tendi_close", showsActionButton: Bool = true) {
        avatarImageView.image = UIImage(named: user.avatarImageName) ?? UIImage(named: "tendi_avatar")
        nicknameLabel.text = user.nickname
        removeButton.isHidden = showsActionButton == false
        removeButton.isEnabled = showsActionButton
        removeButton.setImage(UIImage(named: actionImageName), for: .normal)
    }

    @objc private func removeButtonTapped() {
        removeButtonClickHandler?()
    }
}
