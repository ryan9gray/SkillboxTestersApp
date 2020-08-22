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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.setImageWithSD(from: Profile.current?.avatar ?? "")
    }

}
