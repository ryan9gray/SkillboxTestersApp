//
//  ProductFlow.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 23.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class ProductFlow {
    let service = NetworkService.shared

    private weak var fromViewController: UIViewController?


    func start(from: UIViewController, with product: Product) {
        fromViewController = from
        openProduct(product)
    }

    func openProduct(_ product: Product) {
        let controller = ProductViewController.instantiate(fromStoryboard: .feed)
        controller.input = .init(
            item: product,
            getComments: { some in
                self.fetchComments(id: product.id, complition: some)
            }
        )
        controller.output = .init(
            sendComment: { text in

            },
            addToCart: { product in
                if Basket.current?.inBusket(product) ?? false {
                    Basket.current?.products[product] = nil
                } else {
                    Basket.current?.addToCart(product)
                }
            })

        fromViewController?.navigationController?.pushViewController(controller, animated: true)
    }

    func sendComment(_ text: String) {

    }

    func fetchComments(id: String, complition: @escaping ([Comment]) -> Void) {
        service.getComments(id: id, complition: complition)
    }
}
