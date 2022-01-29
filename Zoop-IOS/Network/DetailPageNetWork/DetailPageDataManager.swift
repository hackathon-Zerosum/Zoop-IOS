//
//  DetailPageDataManager.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/30.
//

import Foundation
import Alamofire

class DetailPageDataManager {
    func DetailPageData( _ viewController: DetailPageViewController) {
        let JWToken : String = "eyJraWQiOiJrZXkxIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxIiwibmlja25hbWUiOiJiYiIsImlhdCI6MTY0MzQ2MTQyNSwiZXhwIjoxNjUyMTAxNDI1fQ.1NmXe_fmyHMwWqmr1uylgn-fvmLgEjZI27bj4hOjN3VchOoZ9D4OutvxjgZLRbLzjjEuhLpFoY9TeIMj44Hqgw"
        
        
        AF.request("http://52.79.160.36:8080/ticket/1",
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["AUTHORIZATION": JWToken])
            .validate()
            .responseDecodable(of: DetailPageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> DetailPage Response \(response)")
                    viewController.didSuccess(response)
                    
                case .failure(let error):
                    print("DEBUG >> DetailPage Get Error: \(error)")
                }
            }
    }
}
