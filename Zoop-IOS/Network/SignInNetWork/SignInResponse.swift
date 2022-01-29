//
//  SignInResponse.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/29.
//

import Foundation
struct SignInResponse : Decodable {
    var nickname: String
}

enum status: String, Codable {
    case code001 = "auth-001"
    case code002 = "auth-002"
    case code003 = "auth-003"
    case code004 = "auth-004"
    
    var message: String {
        switch self {
        case .code001:
            return "agfgadsfd"
        case .code002:
            return "sdafadsf"
        case .code003:
            return "DAFasdfdsa"
        case .code004:
            return "DSFaadsafs"
        }
    }
}
struct SigninResponse: Decodable {
    let statusCode: status
}
//SigninResponse().statusCode.message
