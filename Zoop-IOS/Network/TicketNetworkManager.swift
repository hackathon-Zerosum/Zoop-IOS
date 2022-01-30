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

struct TicketLike: Decodable {
    let likes: Bool
    let ticketId: Int
}
struct TicketLikeRequest: Encodable {
    let ticketId: Int
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
    static func updateLiketTicket(ticketId: Int, completion: @escaping (TicketLike) -> Void) {
        let url = Constant.url + "/ticket/wish"
        
        let parameters = [
            "ticketId" : ticketId
        ]
        AF.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: ["AUTHORIZATION" : "eyJraWQiOiJrZXkxIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxIiwibmlja25hbWUiOiJiYiIsImlhdCI6MTY0MzQ2MTQyNSwiZXhwIjoxNjUyMTAxNDI1fQ.1NmXe_fmyHMwWqmr1uylgn-fvmLgEjZI27bj4hOjN3VchOoZ9D4OutvxjgZLRbLzjjEuhLpFoY9TeIMj44Hqgw"]).responseDecodable(of: TicketLike.self) { result in
            print(result)
            switch result.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    static func getLikeTickets(completion: @escaping (TicketList?) -> Void) {
        let url = Constant.url + "/ticket/wish/"
       
        AF.request(url, method: .get,headers: HTTPHeaders(["AUTHORIZATION" : "eyJraWQiOiJrZXkxIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxIiwibmlja25hbWUiOiJiYiIsImlhdCI6MTY0MzQ2MTQyNSwiZXhwIjoxNjUyMTAxNDI1fQ.1NmXe_fmyHMwWqmr1uylgn-fvmLgEjZI27bj4hOjN3VchOoZ9D4OutvxjgZLRbLzjjEuhLpFoY9TeIMj44Hqgw"])).responseDecodable(of: TicketList.self) { response in
            switch response.result {
            case .success(let tickets):
                completion(tickets)
            case .failure(let error):
                completion(nil)
            }
        }
    }
    
    struct BuyTicket: Decodable {
        let reward: String
    }
    static func getBuyTicket(ticketId: Int, completion: @escaping (_ image: String) -> Void) {
        let url = Constant.url + "/order"
        let parameter = [
            "ticketId": ticketId
        ]
        
        AF.request(url,method: .post,parameters: parameter,encoding: JSONEncoding.default, headers: HTTPHeaders(["AUTHORIZATION" : "eyJraWQiOiJrZXkxIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxIiwibmlja25hbWUiOiJiYiIsImlhdCI6MTY0MzQ2MTQyNSwiZXhwIjoxNjUyMTAxNDI1fQ.1NmXe_fmyHMwWqmr1uylgn-fvmLgEjZI27bj4hOjN3VchOoZ9D4OutvxjgZLRbLzjjEuhLpFoY9TeIMj44Hqgw"])).responseDecodable(of: BuyTicket.self) { buyTicket in
            switch buyTicket.result {
            case .success(let ticket):
                print(ticket.reward)
                completion(ticket.reward)
            case .failure(let error):
                print(error)
            }
        }
    }
}

