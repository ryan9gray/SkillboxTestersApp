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
    func libCamOpen() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    func imageGet(_ image: UIImage) {

    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageGet(image)
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
