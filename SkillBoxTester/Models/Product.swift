//
//  Product.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 22.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import ObjectMapper

final class Product: Mappable {
    var title: String = ""
    var price: String = ""
    var imageUrl: String = ""

    required init?(map: Map) {}

    func mapping(map: Map) {
        title       <- map["name"]
        price       <- map["price"]
        imageUrl       <- map["imageUrl"]
    }
}
final class Comment: Mappable {
    var text: String = ""
    var user: String = ""

    required init?(map: Map) {}

    func mapping(map: Map) {
        text       <- map["text"]
        user       <- map["user"]
    }
}
