//
//  InfoViewController.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 29.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet private var nickTextField: SkyFloatingLabelTextField!
    @IBOutlet private var aboutTextField: SkyFloatingLabelTextField!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var avatarContainerView: UIView!
    @IBOutlet private var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private var enterButton: UIButton!
    @IBOutlet private var nameErrorLabel: UILabel!

    private let keyboardBehavior = KeyboardBehavior()

    @IBAction private func enterTap() {
        save()
        navigationController?.popViewController(animated: true)
    }
    struct Output {
        var getAvatar: (_ completion: @escaping (String?) -> Void) -> Void
        var upload: (UIImage?) -> Void
    }
    var output: Output!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        nickTextField.placeholder = "user_name".localized
        hideKeyboardWhenTappedAround(cancelsTouchesInView: true)
        keyboardBehavior.animations = { [weak self] frame, options, duration in
            guard let self = self else { return }

            let frameInView = self.view.convert(frame, from: nil)
            let offset = max(self.view.bounds.maxY - frameInView.minY, 0)
            self.bottomLayoutConstraint.constant = offset + 16
            self.view.layoutIfNeeded()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nickTextField.becomeFirstResponder()
        keyboardBehavior.subscribe()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        keyboardBehavior.unsubscribe()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2.0
    }

    func setupUI() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editAvatarTap(_:)))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        enterButton.setTitle("continue".localized, for: .normal)
        setupFields()
    }

    func save() {
        Profile.current?.username = nickTextField.text!
        Profile.current?.about = aboutTextField.text!
    }

    func setupFields() {
        nickTextField.text = Profile.current?.username
        aboutTextField.text = Profile.current?.about
    }

    @objc func editAvatarTap(_ sender: Any) {
        dismissKeyboard()
        libCamOpen()
    }

    func libCamOpen() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    func imageGet(_ image: UIImage) {
        output.upload(image)
        avatarImageView.image = image
    }
}
extension InfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageGet(image)
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
