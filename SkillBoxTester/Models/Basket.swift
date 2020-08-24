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

    var products: [Stand] = []

    var foo: String = ""

    func addToCart(_ product: Product) {
        if let prod = products.first(where: { $0.product?.id == product.id }) {
            prod.count += 1
        } else {
            products.append(.init(product: product, count: 1))
        }
        save()
    }

    func remove(_ product: Product) {
        if let idx = products.firstIndex(where: { $0.product?.id == product.id }) {
            products.remove(at: idx)
        }
    }

    func cost() -> Double {
        products.map { $0.product!.price.doubleValue! * Double($0.count)  }.reduce(0, +)
    }

    func count(of product: Product) -> Int {
        products.first(where: { $0.product?.id == product.id })?.count ?? 0
    }

    func inBusket(_ product: Product) -> Bool {
        count(of: product) > 0
    }

    init() {
    }
    
    required init?(map: Map) { }

    func mapping(map: Map) {
		products <- map["products"]
        foo <- map["foo"]
    }

    func save() {
        AppCacher.mappable.saveObject(self)
    }
}
final class Stand: Mappable  {

    var product: Product?
    var count: Int = 1

    internal init(product: Product, count: Int = 1) {
        self.product = product
        self.count = count
    }
    required init?(map: Map) { }

    func mapping(map: Map) {
        product <- map["product"]
        count <- map["count"]
    }
}
