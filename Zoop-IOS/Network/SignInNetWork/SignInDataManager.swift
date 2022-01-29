//
//  SignInDataManager.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/29.
//

import Foundation
import Alamofire

class SignInDataManager {
    func signInPostData() {
        let url = "\(Constant.BASE_URL)/auth/signup"
        let param = ["email" : SignInUserInfo.email,
                     "nickname" : SignInUserInfo.nickname,
                     "phone" : SignInUserInfo.phone,
                     "password" : SignInUserInfo.password,
                     "passwordCheck" : SignInUserInfo.passwordCheck
        ]
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
            .validate()
            .responseDecodable(of: SignInResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> Success \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
