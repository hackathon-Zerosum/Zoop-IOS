//
//  Login.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import Foundation
//  Created by 류창휘 on 2022/01/30.
//

import Foundation

struct LogInUserInfo {
    static var email = ""
    static var password = ""
    static var deviceName = ""
    static var deviceToken = ""

}
//
//  LoginResponse.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/30.
//

import Foundation
struct LogInResponse: Decodable {
    var memberId: Int
    var nickname: String
    var accessToken: String
    var refreshToken: String
}

import Foundation
import Alamofire

class  LogInDataManager {
    func logInPostData() {
        let url = "http://52.79.160.36:8080/auth/signin"
        let param = ["email" : LogInUserInfo.email,
                     "password" : LogInUserInfo.password,
                     "deviceName" : LogInUserInfo.deviceName,
                     "deviceToken" : LogInUserInfo.deviceToken]
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: LogInResponse.self) {
                response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success (response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
