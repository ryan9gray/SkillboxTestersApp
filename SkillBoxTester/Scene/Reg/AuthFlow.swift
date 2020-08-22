//
//  AuthFlow.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class AuthFlow {
    let initialViewController: UINavigationController

    init() {
        let navigationController = UINavigationController()
        initialViewController = navigationController
    }

    func start() {
        initialViewController.setViewControllers([ createInitialViewController() ], animated: false)
        initialViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "icQuestions"),
            selectedImage: UIImage(named: "icQuestions")
        )
    }

    private func createInitialViewController() -> UIViewController {
        AuthViewController.instantiate(fromStoryboard: .autorization)
    }
}
