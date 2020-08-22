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

    var products: [Product] = []

    required init?(map: Map) { }

    func mapping(map: Map) {
		products <- map["products"]
    }

    func save() {
        AppCacher.mappable.saveObject(self)
    }
}
