//
//  ProfileFlow.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileFlow {

    let initialViewController: UINavigationController
    let service = NetworkService.shared

    init() {
        let navigationController = UINavigationController()
        initialViewController = navigationController
    }

    func start() {
        initialViewController.setViewControllers([ createInitialViewController() ], animated: false)
        initialViewController.tabBarItem = UITabBarItem(
            title: "profile".localized,
            image: nil,
            selectedImage: nil
        )
    }

    private func createInitialViewController() -> UIViewController {
        let controller = ProfileViewController.instantiate(fromStoryboard: .profile)
        controller.output = .init(
            logout: logout,
            getAvatar: getProfile,
            upload: uploadImage
//            infoOpen: { [weak controller] in
//                self.openInfo(from: controller)
//            }
        )
        return controller
    }

    func uploadImage(_ image: UIImage?) {
        service.upload(image: image, completion: { result in
            
        }) { count in
            print(count)
        }
    }

    func getProfile(complition: @escaping (String?) -> Void) {
        service.getProfile(complition: complition)
    }

    func logout() {
        Profile.current = nil
        AppCacher.mappable.removeValue(of: Profile.self)
        ViewHierarchyWorker.resetAppForAuthentication()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    func openInfo(from: UIViewController?) {
        let controller = InfoViewController.instantiate(fromStoryboard: .profile)
        controller.output = .init(getAvatar: getProfile, upload: uploadImage)
        from?.navigationController?.pushViewController(controller, animated: true)
    }
}
