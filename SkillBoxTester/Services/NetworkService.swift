//
//  NetworkService.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 22.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import Alamofire
import ObjectMapper
import SwiftyJSON

/// Больно, но быстро (название твоего домашнего видео)
class NetworkService {

	static let shared = NetworkService()

	static let baseUrl = "http://85.119.146.20:3000/"

    func getProducts(complition: @escaping ([Product]) -> Void) {
		AF.request(NetworkService.baseUrl + "api/v1/products/").responseJSON { response in
            debugPrint(response)
            guard let data = response.data else { return complition([]) }
			let json = JSON(data)["info"]["products"]
			let products = Mapper<Product>().mapArray(JSONString: json.description) ?? []
            complition(products)
        }
    }

    func getComments(id: String, complition: @escaping ([Comment]) -> Void) {
        AF.request(NetworkService.baseUrl + "api/v1/products/\(id)/comments").responseJSON { response in
            debugPrint(response)
            guard let data = response.data else { return complition([]) }
            let json = JSON(data)["info"]["comments"]
            let comment = Mapper<Comment>().mapArray(JSONString: json.description) ?? []
            complition(comment)
        }
    }

    func getProfile(complition: @escaping (String?) -> Void) {
        guard let id = Profile.current?.profileId else { return }

        AF.request(NetworkService.baseUrl + "api/v1/profile/\(id)").responseJSON { response in
            debugPrint(response)
            guard
                let data = response.data,
                let avatar = JSON(data)["info"]["avatar"].string
            else { return complition(nil) }

            Profile.current?.avatar = avatar
            complition(avatar)
        }
    }

    func updateProfile() {

    }

}
