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
	var date: String = ""
	var size: Size?
	var info: String = ""

    required init?(map: Map) {}

    func mapping(map: Map) {
        title       <- map["name"]
        price       <- map["price"]
        imageUrl       <- map["productImage"]
		date       <- map["date"]
		size       <- map["size"]
		info       <- map["info"]
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
final class Size: Mappable {
	var height: Int = 0
	var width: Int = 0

	required init?(map: Map) {}

	func mapping(map: Map) {
		height       <- map["height"]
		width       <- map["width"]
	}
}

