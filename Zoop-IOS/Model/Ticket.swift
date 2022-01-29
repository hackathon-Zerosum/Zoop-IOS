//
//  Ticket.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import Foundation

struct TicketList: Decodable {
    let tickets: [Ticket]
}
struct Ticket: Decodable {
    let ticketId: Int
    let name: String
    let image: String
    let originPrice: Int
    let sellingPrice: Int
    let discount: Int
    let expiredAt: String
}
