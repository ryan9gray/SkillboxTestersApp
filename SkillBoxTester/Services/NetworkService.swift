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
			let json = JSON(response.data)["info"]["products"]
			let products = Mapper<Product>().mapArray(JSONString: json.description) ?? []
            complition(products)
        }
    }

    func getComments(id: String, complition: @escaping ([Comment]) -> Void) {
        AF.request(NetworkService.baseUrl + "api/v1/products/\(id)/comments").responseJSON { response in
            debugPrint(response)
            let json = JSON(response.data)["info"]["comments"]
            let comment = Mapper<Comment>().mapArray(JSONString: json.description) ?? []
            complition(comment)
        }
    }


    func defineOriginalLanguage(ofText: String) {
        let text =  ofText
		let stringURL = NetworkService.baseUrl + "api/v1/products/"
        let url = URL(string: stringURL)

        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = text.data(using: .utf8)

        AF.request(request)
            .responseJSON { response in
                print(response)
        }
    }
}
