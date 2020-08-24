//
//  Product.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 22.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import ObjectMapper

final class Product: Mappable, Hashable {
    var title: String = ""
    var price: String = ""
    var imageUrl: String = ""
	var date: String = ""
	var size: Size?
	var info: String = ""
    var id: String = ""
    var performance: String = ""

    required init?(map: Map) {}

    func mapping(map: Map) {
        title       <- map["name"]
        price       <- map["price"]
        imageUrl       <- map["productImage"]
		date       <- map["date"]
		size       <- map["size"]
		info       <- map["info"]
        id       <- map["_id"]
        performance       <- map["performance"]
    }

    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class Comment: Mappable {
    var text: String = ""
    var userId: String = ""
    var userName: String = ""
    var productId: String = ""
    var id: String = ""
    var subComments: [Comment] = []

    required init?(map: Map) {}

    func mapping(map: Map) {
        text       <- map["text"]
        userId       <- map["userId"]
        userName       <- map["userName"]
        id       <- map["_id"]
        productId       <- map["productId"]
        subComments       <- map["subComments"]
    }
}

final class Size: Mappable {
	var height: Int = 0
	var width: Int = 0

	required init?(map: Map) {}

	func mapping(map: Map) {
		height       <- map["height"]
		width       <- map["width"]
	}
}

