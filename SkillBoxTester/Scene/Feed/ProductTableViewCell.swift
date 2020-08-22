//
//  ProductTableViewCell.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(title: NSAttributedString, subtitle: NSAttributedString?, imageUrl: String) {
        iconView.setImageWithSD(from: imageUrl)
        titleLabel.attributedText = title
        subTitleLabel.attributedText = subtitle
        subTitleLabel.isHidden = subtitle == nil
    }
}
