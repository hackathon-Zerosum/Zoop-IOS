//
//  MyPageViewController.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//
//
//  MyPageViewController.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/30.
//

import UIKit
import Kingfisher
import Alamofire


struct MyPageResponse: Decodable {
    var member: member
    var ticket: myTicket
}

struct member: Decodable {
    var memberId: Int
    var nickname: String
    var avatar : String
}

struct myTicket: Decodable {
    var ticketId : Int
    var image: String
    var name: String
}




class MyPageDataManager {
    func myPageData(_ viewController : MyPageViewController) {
        let JWToken : String = "eyJraWQiOiJrZXkxIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxIiwibmlja25hbWUiOiJiYiIsImlhdCI6MTY0MzQ2MTQyNSwiZXhwIjoxNjUyMTAxNDI1fQ.1NmXe_fmyHMwWqmr1uylgn-fvmLgEjZI27bj4hOjN3VchOoZ9D4OutvxjgZLRbLzjjEuhLpFoY9TeIMj44Hqgw"


        AF.request("http://52.79.160.36:8080/member",
                   method: .get,
                   parameters: nil,
                   headers: ["AUTHORIZATION" : JWToken])
            .validate()
            .responseDecodable(of: MyPageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG >> MyPage Response (response)")
                    viewController.myPagedidSuccess(response)
                case .failure(let error):
                    print("DEBUG >> MyPage Get Error: (error)")
                }

            }
    }
}

class MyPageViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!

    @IBOutlet weak var ticketName: UILabel!
    @IBOutlet weak var ticketImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        MyPageDataManager().myPageData(self)
        // Do any additional setup after loading the view.
        myImageView.layer.cornerRadius = myImageView.frame.height / 2

        ticketImage.layer.cornerRadius = 8
    }


 
}

extension MyPageViewController {
    func myPagedidSuccess(_ resonse: MyPageResponse) {
        self.myImageView.kf.setImage(with: URL(string: resonse.member.avatar))
        self.myNameLabel.text = resonse.member.nickname
        self.ticketName.text = resonse.ticket.name
        self.ticketImage.kf.setImage(with: URL(string: resonse.ticket.image))
    }
}
