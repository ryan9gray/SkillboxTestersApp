//
//  NetworkService.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 22.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import Alamofire
import ObjectMapper

/// Больно, но быстро (название твоего домашнего видео)
class NetworkService {


    func getProducts(complition: @escaping ([Product]) -> Void) {
        AF.request("https://httpbin.org/get").responseJSON { response in
            debugPrint(response)
            let products = Mapper<Product>().mapArray(JSONObject:response.description) ?? []
            complition(products)
        }
    }

    func defineOriginalLanguage(ofText: String) {
        let text =  ofText
        let stringURL = "basicURL" + "identify?version=2018-05-01"
        let url = URL(string: stringURL)

        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.httpBody = text.data(using: .utf8)

        AF.request(request)
            .responseJSON { response in
                print(response)
        }
    }
}
