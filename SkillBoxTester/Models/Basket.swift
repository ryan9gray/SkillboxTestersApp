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

    static var isAuthorized: Bool {
        current != nil
    }

    var id: Int = 0
    var isConfirmed: Bool?
    var email: String?
    var phone: String?
    var avatar: String?
    var name: String = ""

    required init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["uid"]
        email <- map["email"]
        name <- map["first_name"]
        phone <- map["phone"]
    }

    func save() {
        AppCacher.mappable.saveObject(self)
    }
}
