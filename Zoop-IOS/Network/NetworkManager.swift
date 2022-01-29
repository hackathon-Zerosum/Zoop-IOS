//
//  NetworkManager.wift.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import Foundation
import Alamofire

struct TicketRequestModel: Encodable {
    let begin: String
    let end: String
    let category: Int
    let page: Int
    let sort: Int
}
struct TicketNetworkManager {
    
    static func getTickets(region: Int, begin: String,end: String, category: Int, page: Int, sort: Int, completion: @escaping (TicketList?) -> Void) {
        let url = Constant.url + "/ticket/region/\(region)"
        let parameter = TicketRequestModel(begin: begin, end: end, category: category, page: page, sort: sort)
        AF.request(url, method: .get, parameters: parameter,headers: HTTPHeaders(["AUTHORIZATION" : "eyJraWQiOiJrZXkxIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxIiwibmlja25hbWUiOiJiYiIsImlhdCI6MTY0MzQ2MTQyNSwiZXhwIjoxNjUyMTAxNDI1fQ.1NmXe_fmyHMwWqmr1uylgn-fvmLgEjZI27bj4hOjN3VchOoZ9D4OutvxjgZLRbLzjjEuhLpFoY9TeIMj44Hqgw"])).responseDecodable(of: TicketList.self) { response in
            switch response.result {
            case .success(let tickets):
                completion(tickets)
            case .failure(let error):
                completion(nil)
            }
        }
    }
}

