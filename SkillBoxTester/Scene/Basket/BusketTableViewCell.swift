//
//  BusketTableViewCell.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 22.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class BusketTableViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var countLabel: UILabel!

    var count: Int = 1

    struct Output {
        var countDidChange: (Int) -> Void
    }
    var output: Output!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func minusTap(_ sender: Any) {
        guard count > 0 else { return }

        count -= 1
        titleLabel.text = count.stringValue
        output.countDidChange(count)
    }

    @IBAction func plusTap(_ sender: Any) {
        count += 1
        titleLabel.text = count.stringValue
        output.countDidChange(count)
    }

    func set(title: NSAttributedString, subtitle: NSAttributedString?, imageUrl: String) {
        productImageView.setImageWithSD(from: imageUrl)
        titleLabel.attributedText = title
        priceLabel.attributedText = subtitle
        priceLabel.isHidden = subtitle == nil
    }
}
