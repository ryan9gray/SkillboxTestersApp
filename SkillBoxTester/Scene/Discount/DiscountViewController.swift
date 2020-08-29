//
//  DiscountViewController.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class DiscountViewController: FeedViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func fetchItems() {
        input.getItems { [weak self] products in
            var item = products.filter { $0.performance.boolValue }
            item.append(products.last!)
            self?.items = item
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}
