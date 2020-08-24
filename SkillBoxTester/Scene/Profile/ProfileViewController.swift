//
//  ProfileViewController.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!

    @IBAction func logOutTap(_ sender: Any) {
        output.logout()
    }

    struct Output {
        var logout: () -> Void
        var getAvatar: (_ completion: @escaping (String?) -> Void) -> Void
    }
    var output: Output!

    override func viewDidLoad() {
        super.viewDidLoad()

        output.getAvatar { [weak self] url in
            guard let url = url, let self = self else { return }

            self.imageView.setImageWithSD(from: url)
        }
    }

}
