//
//  Basket.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 22.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import ObjectMapper

final class Basket: Mappable  {
    static var current: Basket? = AppCacher.mappable.getObject(of: Basket.self) {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name.BasketDidChanged, object: current)
        }
    }

    var products: [Product: Int] = [:]

    func addToCart(_ product: Product) {
        if inBusket(product) {
            products[product]! += 1
        } else {
            products[product] = 1
        }
        save()
    }

    func remove(_ product: Product) {
        if let count = products[product] {
            if count > 1 {
                products[product]! -= 1
            } else {
                products[product] = nil
            }
        }
    }

    func count(of product: Product) -> Int {
        products[product] ?? 0
    }

    func inBusket(_ product: Product) -> Bool {
        count(of: product) > 0
    }

    init() {
    }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
		products <- map["products"]
    }

    func save() {
        AppCacher.mappable.saveObject(self)
    }
}
