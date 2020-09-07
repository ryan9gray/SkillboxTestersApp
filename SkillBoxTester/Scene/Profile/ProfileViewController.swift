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
    @IBOutlet var avatarXConstraint: NSLayoutConstraint!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var aboutLabel: UILabel!

    @IBAction func logOutTap(_ sender: Any) {
        output.logout()
    }
    @IBAction func editAvatarTap(_ sender: Any) {
        libCamOpen()
    }
    
    struct Output {
        var logout: () -> Void
        var getAvatar: (_ completion: @escaping (String?) -> Void) -> Void
        var upload: (UIImage?) -> Void
        //var infoOpen: () -> Void
    }
    var output: Output!

    override func viewDidLoad() {
        super.viewDidLoad()

        avatarXConstraint.constant = view.bounds.width / 2 - 60
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.nameLabel.text = Profile.current?.username
        self.aboutLabel.text = Profile.current?.about
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        output.getAvatar { [weak self] url in
            guard let url = url, let self = self else { return }

            self.imageView.setImageWithSD(from: url)
            self.nameLabel.text = Profile.current?.username
            self.aboutLabel.text = Profile.current?.about
        }
    }

    func libCamOpen() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    func imageGet(_ image: UIImage) {
        output.upload(image)
        imageView.image = image
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
