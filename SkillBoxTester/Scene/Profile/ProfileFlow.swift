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
            getAvatar: getProfile
        )
        return controller
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
}
