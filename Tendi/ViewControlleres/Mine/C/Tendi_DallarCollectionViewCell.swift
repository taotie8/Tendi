//
//  Tendi_DallarCollectionViewCell.swift
//  Tendi
//
//  Created by JIAO on 2026/7/20.
//

import UIKit

class Tendi_DallarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cell_bg: UIImageView!
    @IBOutlet weak var coinCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        coinCountLabel.adjustsFontSizeToFitWidth = true
        coinCountLabel.minimumScaleFactor = 0.72
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.minimumScaleFactor = 0.72
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        accessibilityIdentifier = nil
    }

    func configure(price: String, coinAmount: Int, productIdentifier: String, isFeatured: Bool) {
        cell_bg.image = UIImage(named: isFeatured ? "dallar_99" : "person_cell_bg")
        priceLabel.text = "$\(price)"
        coinCountLabel.text = "\(coinAmount)"
        coinCountLabel.textColor = UIColor(red: 22 / 255.0, green: 24 / 255.0, blue: 25 / 255.0, alpha: 1)
        accessibilityIdentifier = productIdentifier
    }

}
