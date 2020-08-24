//
//  FeedFlow.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class FeedFlow {
    let initialViewController: UINavigationController

	let service = NetworkService.shared
    
    init() {
        let navigationController = UINavigationController()
        initialViewController = navigationController
    }

    func start() {
        initialViewController.setViewControllers([ createInitialViewController() ], animated: false)
        initialViewController.tabBarItem = UITabBarItem(
            title: "feed".localized,
            image: nil,
            selectedImage: nil
        )
    }

    private func createInitialViewController() -> UIViewController {
        let feed = FeedViewController.instantiate(fromStoryboard: .feed)
        feed.input = .init(getItems: fetchProducts)
        feed.output = .init(
            priductTap: { [weak feed] product in
                guard let from = feed else { return }

                let flow = ProductFlow()
                flow.start(from: from, with: product)
            }
        )
        return feed
    }

    func fetchProducts(complition: @escaping ([Product]) -> Void) {
		service.getProducts(complition: complition)
    }
}
