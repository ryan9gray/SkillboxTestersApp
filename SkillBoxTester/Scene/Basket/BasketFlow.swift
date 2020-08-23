//
//  BasketFlow.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class BasketFlow {
    let initialViewController: UINavigationController

    init() {
        let navigationController = UINavigationController()
        initialViewController = navigationController

        if !LocalStore.notFirstLaunch {
            Basket.current = Basket()
            Basket.current?.save()
            LocalStore.notFirstLaunch = true
        }
    }

    func start() {
        initialViewController.setViewControllers([ createInitialViewController() ], animated: false)
        initialViewController.tabBarItem = UITabBarItem(
            title: "basket".localized,
            image: nil,
            selectedImage: nil
        )
    }

    private func createInitialViewController() -> UIViewController {
        BasketViewController.instantiate(fromStoryboard: .basket)
    }
}
