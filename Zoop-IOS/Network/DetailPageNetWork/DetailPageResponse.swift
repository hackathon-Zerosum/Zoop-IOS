//
//  DetailPageResponse.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/30.
//

import Foundation
import Alamofire
struct DetailPageResponse: Decodable {
    var seller : seller
    var likes: Bool
    var ticket : ticket
}

struct seller: Decodable {
    var memberId: Int
    var avatar: String?
    var nickname: String
}

struct ticket : Decodable {
    var ticketId: Int
    var name: String
    var image: String
    var beginAt: String
    var endAt: String
    var expiredAt: String
    var originPrice: Int
    var sellingPrice: Int
    var discount : Int
}
