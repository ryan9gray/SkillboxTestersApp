//
//  ProductService.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 24.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import Alamofire
import ObjectMapper
import SwiftyJSON

struct ProductService {

    func sendComment(params: Body, completion: @escaping (Bool) -> Void) {
        let stringURL = NetworkService.baseUrl + "api/v1/comments"

        var request = URLRequest(url: URL(string: stringURL)!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = try? JSONEncoder().encode(params)//JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        request.httpBody = body

        AF.request(request)
            .responseJSON { response in
                print(response)
                switch response.result {
                    case .success(let data):
                        //let json = JSON(data)["info"]
                        completion(true)
                    case .failure(let error):
                        print(error)
                        completion(false)
                }

        }
    }

    struct Body: Encodable {
        internal init(productId: String, text: String) {
            self.productId = productId
            self.text = text
            self.userName = ""
            self.userId = "userId"
        }

        let productId: String
        let userId: String
        let text: String
        let userName: String
    }

}
