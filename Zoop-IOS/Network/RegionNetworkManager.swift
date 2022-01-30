//
//  RegionNetworkManager.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import Foundation
import Alamofire
struct HotRegions: Codable {
    let states: [HotRegion]
}
struct HotRegion: Codable {
    let stateId: Int
    let name: String
    let image: String
    let max: Int
    let tickets: [String]
}

struct InterestRegions: Codable {
    let regions: [InterestRegion]
}

struct InterestRegion: Codable {
    let regionId: Int
    let name: String
}
struct RegionNetworkManager {
    static let header = HTTPHeaders(["AUTHORIZATION" : "eyJraWQiOiJrZXkxIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxIiwibmlja25hbWUiOiJiYiIsImlhdCI6MTY0MzQ2MTQyNSwiZXhwIjoxNjUyMTAxNDI1fQ.1NmXe_fmyHMwWqmr1uylgn-fvmLgEjZI27bj4hOjN3VchOoZ9D4OutvxjgZLRbLzjjEuhLpFoY9TeIMj44Hqgw"])
    static func getPopularRegion(completion: @escaping (HotRegions) -> Void) {
        let url = Constant.url + "/ticket/hot"
        
        AF.request(url,headers: RegionNetworkManager.header).responseDecodable(of: HotRegions.self) { response in
            switch response.result {
            case .success(let regions):
                print(regions)
                completion(regions)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getInterestRegion(completion: @escaping ([InterestRegion]) ->  Void) {
        let url = Constant.url + "/ticket/wish/location"
        
        AF.request(url, headers: RegionNetworkManager.header ).responseDecodable(of:InterestRegions.self) { response in
            switch response.result {
            case .success(let regions):
                print(regions)
                completion(regions.regions)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
